# Escanor AWS — Getting Started

This guide is written for a learner who clones the AWS Master Reference and wants to build the Escanor lab in a personal, disposable AWS account. The repository does not deploy anything automatically.

## 1. What you will build

The default lab creates a small set of AWS resources:

- Amazon VPC with one public subnet and two private database subnets.
- Internet Gateway and public route for outbound EC2 package installation.
- One Amazon Linux 2023 EC2 instance (`t3.micro` default) with no inbound security-group rules.
- One Single-AZ Amazon RDS for PostgreSQL instance (`db.t4g.micro` default) with 20 GiB encrypted storage.
- One private S3 bucket with Block Public Access, bucket-owner-enforced ownership, default encryption and versioning.
- S3 Gateway Endpoint.
- Systems Manager `ssm` and `ssmmessages` interface endpoints, plus `ec2messages` for compatible Regions / agent versions.
- IAM instance profile, Session Manager access and RDS IAM database authentication.
- A Python web app that writes a note to RDS and uploads / lists objects and their S3 versions.

The EC2 public IPv4 is for outbound Internet access only. The app is reached using Session Manager port forwarding. No SSH key pair is created and no inbound rule is configured.

## 2. Prerequisites

Install:
- Git.
- AWS CLI v2.
- Terraform CLI 1.10 or later (the CI currently validates with 1.17.1).
- Python 3.11 or later.
- A terminal with Bash. On Windows, use Git Bash or WSL for the shell scripts.

Your AWS identity needs permission to create the resources in the lab, create the S3 state bucket, create IAM roles / instance profiles and read the RDS-managed master secret during the one-time DB bootstrap. For a governed organization, obtain approval from the AWS account owner first.

Install the Session Manager plugin if your AWS CLI installation does not already include it. Do not create IAM user access keys for this lab; use AWS IAM Identity Center or an approved federated role.

## 3. Clone the AWS Vault

```bash
git clone https://github.com/tripathies/azure-master-vault.git
cd azure-master-vault
```

The project is under:
```text
aws-master-reference/projects/escanor/
```

## 4. Sign in and verify the AWS account

For an AWS IAM Identity Center profile, configure it once:

```bash
aws configure sso --profile escanor-lab
aws sso login --profile escanor-lab
```

Set the profile and Region in the current terminal:

```bash
export AWS_PROFILE=escanor-lab
export AWS_REGION=ap-south-1
export EXPECTED_AWS_ACCOUNT_ID='<your-disposable-account-id>'
```

Verify the active identity before creating anything:

```bash
aws sts get-caller-identity
bash aws-master-reference/projects/escanor/scripts/aws-preflight.sh
```

Do not continue if the account ID or assumed role is unexpected. Prefer a dedicated non-production AWS member account. Do not use the Organizations management, Log Archive or Audit / Security Tooling account.

## 5. Bootstrap the Terraform state bucket

The workload Terraform state is stored in a separate S3 bucket with versioning, encryption and public-access blocking. Bootstrap it once:

```bash
cd aws-master-reference/projects/escanor
bash scripts/bootstrap-state-backend.sh
```

The script creates the S3 state bucket and writes a local `infra/terraform/backend.hcl`. The generated file is git-ignored. Keep a record of the bucket name. The state bucket is deliberately not destroyed by the Escanor workload Terraform state.

Then initialise the workload root module:

```bash
cd infra/terraform
cp terraform.tfvars.example terraform.tfvars
terraform init -backend-config=backend.hcl
```

Do not copy `backend.hcl` into source control. The state bucket is a separate persistent prerequisite and can incur a small storage charge.

## 6. Review and apply Terraform

Run static checks first:

```bash
terraform fmt -check -recursive
terraform validate
terraform plan -out=tfplan
terraform show tfplan
```

Review the complete plan. Confirm:
- The expected AWS account and Region.
- The EC2 and RDS instance classes.
- The S3 bucket and endpoint policies.
- The EC2 security group has no ingress rules.
- The RDS instance is not publicly accessible.
- The RDS database subnet group uses private subnets.
- The S3 Gateway Endpoint is attached to the route tables.
- The Systems Manager interface endpoint resources match your cost / access choice.

Only then apply the saved plan:

```bash
terraform apply tfplan

# Return to the Escanor project root for the helper scripts and app commands.
cd ../..
```

Terraform outputs provide the EC2 instance ID, private RDS endpoint, S3 bucket and SSM commands. The EC2 user-data process can take several minutes to install the application. Check Systems Manager managed-node status before starting a session.

## 7. Create the application database role

The EC2 instance does not receive the RDS master password. RDS stores the master credential in Secrets Manager. Use your local AWS identity to read that secret once and create the restricted application role.

### Terminal A — start the private RDS port forward

From the Escanor project directory:

```bash
bash scripts/forward-rds-port.sh
```

Keep this terminal open. Session Manager forwards local port 15432 to the private RDS endpoint through the EC2 instance.

### Terminal B — download the RDS CA bundle and bootstrap the role

```bash
mkdir -p "$HOME/.aws"
curl --fail --silent --show-error --location \
  https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem \
  --output "$HOME/.aws/rds-global-bundle.pem"

python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r app/requirements.txt

REGION="$(terraform -chdir=infra/terraform output -raw aws_region)"
DB_HOST="$(terraform -chdir=infra/terraform output -raw rds_endpoint)"
SECRET_ARN="$(terraform -chdir=infra/terraform output -raw rds_master_secret_arn)"

python scripts/bootstrap-db-user.py \
  --region "$REGION" \
  --db-host "$DB_HOST" \
  --secret-arn "$SECRET_ARN" \
  --local-port 15432 \
  --ssl-root-cert "$HOME/.aws/rds-global-bundle.pem"
```

The script uses the AWS CLI credential chain to read the RDS-managed master secret. It creates the `escanor_app` PostgreSQL role, grants the RDS `rds_iam` role and creates the sample `lab_notes` table. The EC2 application identity has only the `rds-db:connect` permission scoped to that database user.

Close Terminal A when the bootstrap reports success.

## 8. Open the application without public ingress

From the Escanor project directory:

```bash
bash scripts/forward-app-port.sh
```

Keep this session open and browse to:

```text
http://127.0.0.1:8080
```

The port forward connects your local browser to EC2 port 8080 through Session Manager. The EC2 security group remains without inbound rules.

Use the page to:
1. Run diagnostics. It checks the database connection and S3 list operation.
2. Save a learning note to RDS.
3. Upload an object to S3.
4. List objects in the `uploads/` prefix.
5. Upload a second version using the same filename, then list versions to observe S3 versioning.

The application uses the EC2 instance profile for AWS API access and RDS IAM database authentication. No database password or AWS access key is placed in the app's environment file.

## 9. Explore AWS networking and services

### Verify the private RDS boundary

- RDS has `publicly_accessible = false`.
- RDS security group accepts TCP 5432 only from the EC2 security group.
- RDS subnet group uses private subnets.
- Use the SSM remote-host port-forward to access the private DB from your workstation.

### Verify VPC endpoints

- S3 Gateway Endpoint routes S3 traffic from attached route tables through the AWS network. It has no additional endpoint-hour charge.
- Systems Manager interface endpoints use private IPs and private DNS for SSM control / session messages. They incur hourly and data-processing charges.
- Inspect the endpoint IDs with Terraform outputs or the VPC console.
- The S3 Gateway Endpoint cannot be extended to on-premises networks or other VPCs through peering / Transit Gateway. An S3 Interface Endpoint is needed for those paths and has additional charges.

### Verify Internet egress

The EC2 public subnet has a default route to the Internet Gateway and the instance receives a public IPv4 when `create_public_ipv4_for_ec2 = true`. This supports OS and Python package downloads. Its security group has no ingress rules, so this does not expose the web app inbound. The private RDS subnets have no Internet route or NAT Gateway.

## 10. Run local code and Terraform checks

From the Escanor project directory:

```bash
bash scripts/validate-local.sh
```

This creates a local virtual environment, runs Python compilation and unit tests, then runs Terraform format, initialisation without remote state and validation. It does not deploy AWS resources.

The GitHub Actions pipeline runs the same core checks on relevant pull requests and pushes to `main`. AWS CodeBuild readers can run the same checks using [`buildspec.yml`](../buildspec.yml); see the [CodeBuild setup guide](codebuild.md).

## 11. Destroy the learning resources

When finished, return to the Terraform directory:

```bash
cd infra/terraform
terraform plan -destroy -out=destroy.tfplan
terraform show destroy.tfplan
```

Review the plan carefully, then:

```bash
terraform apply destroy.tfplan
```

The lab intentionally uses `skip_final_snapshot = true`, `deletion_protection = false` and S3 `force_destroy = true`. The database and uploaded objects are deleted. Do not use this profile for data you need to retain.

The separate Terraform state bucket is not deleted by this destroy. Retain it if you may recreate or inspect the lab. Delete it manually only after confirming that the state and all noncurrent object versions are no longer required.

After destroy, inspect EC2, RDS, EBS volumes, snapshots, Elastic IPs / public IPv4 allocations, VPC endpoints and S3 buckets. Check Cost Explorer after billing data refreshes.

## 12. Cost and safety notes

This is a low-footprint lab, not a free guarantee:
- EC2 instance and its encrypted EBS volume incur charges while running.
- Public IPv4 addresses are billable.
- RDS instance hours and storage incur charges; free-plan / credit eligibility varies by account and current AWS offer.
- Interface VPC endpoints incur hourly and data-processing charges. Three endpoints are enabled by default for the default Region / agent combination.
- S3 storage and requests may incur charges.
- There is no NAT Gateway in this design to avoid that additional recurring cost.

Use AWS Pricing Calculator and Budgets before creating resources. Set a short learning window, destroy resources promptly and verify residual resources. Budgets notify; they are not a hard spending cap.

## 13. Troubleshooting

| Symptom | Check |
|---|---|
| EC2 does not appear in Systems Manager | Instance profile, SSM agent status, endpoint security-group ingress 443, endpoint availability and VPC DNS |
| Port-forward fails | Local Session Manager plugin, caller `ssm:StartSession` permission, target is managed / online |
| DB bootstrap times out | RDS status, EC2-to-RDS security-group reference, private DB endpoint, SSM remote-host tunnel and DB subnet group |
| App health works but DB diagnostics fail | App IAM role `rds-db:connect`, PostgreSQL `rds_iam` grant, username / DB name, RDS CA bundle and endpoint |
| S3 upload denied | EC2 role S3 prefix permissions, bucket name, endpoint policy and S3 bucket policy |
| App did not start | `sudo cloud-init status --long`, `sudo systemctl status escanor-app`, `sudo journalctl -u escanor-app` |
| Package install failed | Public IPv4 assignment, public route, Internet Gateway and outbound HTTPS |

Do not solve a private-connectivity failure by adding public RDS access or opening SSH / app ports to the Internet.
