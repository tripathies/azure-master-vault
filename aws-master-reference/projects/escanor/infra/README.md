# Escanor AWS — Terraform Infrastructure

**Status:** Executable Terraform configuration for the small learning-lab profile. The larger EKS / AIOps roadmap is documented separately.

## 1. Resources created

| Layer | Terraform resources | Design |
|---|---|---|
| Network | VPC, Internet Gateway, 3 subnets, route tables and associations | One public subnet plus private subnets in two AZs |
| Private service connectivity | S3 Gateway Endpoint; SSM, ssmmessages and optional ec2messages Interface Endpoints | Endpoint policies and security groups |
| Compute | EC2, IAM role, instance profile, security group | Amazon Linux 2023, t3.micro default, IMDSv2 required, no inbound rules |
| Database | RDS PostgreSQL, DB subnet group and security group | db.t4g.micro default, Single-AZ, encrypted, private, IAM DB authentication |
| Storage | S3 bucket, ownership controls, public-access block, versioning, encryption, lifecycle, TLS-only bucket policy | Private bucket with uploads prefix |
| IAM | EC2 trust role, SSM managed policy and inline app policy | S3 prefix access and rds-db:connect scoped to the app DB user |

The application source is embedded into EC2 user data using Terraform `filebase64()`. On first boot, the instance installs Python dependencies, downloads the RDS CA bundle and starts the Flask/Gunicorn app with systemd.

## 2. Files

- `versions.tf`: Terraform version, backend and provider constraints.
- `variables.tf`: Region, instance sizes, CIDRs, DB and endpoint variables.
- `main.tf`: provider data, AZ selection, tags and generated S3 bucket suffix.
- `network.tf`: VPC, subnets, routes, S3 Gateway Endpoint and Systems Manager Interface Endpoints.
- `security.tf`: security groups; intentionally no EC2 ingress.
- `compute.tf` and `user_data.sh.tftpl`: EC2 application host and bootstrap.
- `database.tf`: private RDS PostgreSQL.
- `storage.tf`: private, encrypted, versioned S3 bucket.
- `iam.tf`: instance role and least-privilege application permissions.
- `outputs.tf`: resource IDs and connection commands.
- `terraform.tfvars.example`: small default lab profile.

## 3. State backend

The root module uses an S3 backend with native S3 lock-file support (`use_lockfile = true`). Terraform 1.10 or later is required. Bootstrap the bucket before initialising this module:

```bash
cd aws-master-reference/projects/escanor/infra/terraform
export AWS_PROFILE=escanor-lab
export AWS_REGION=ap-south-1
bash ../../scripts/bootstrap-state-backend.sh
terraform init -backend-config=backend.hcl
```

The generated `backend.hcl` is local and git-ignored. The state bucket is deliberately separate from the workload bucket and is **not** destroyed by the Escanor workload state. Keep its name and recovery ownership documented. Do not delete the state bucket while the state is still needed.

For team use, restrict the state bucket to the approved Terraform roles, enable versioning and encryption, and establish state recovery and access review. The bootstrap script applies encryption, versioning, public-access blocking and bucket-owner-enforced ownership; a production backend should also receive an audited bucket policy and retention controls appropriate to the organization.

## 4. Apply workflow

From the repository root:

```bash
cd aws-master-reference/projects/escanor/infra/terraform
cp terraform.tfvars.example terraform.tfvars
terraform fmt -check -recursive
terraform init -backend-config=backend.hcl
terraform validate
terraform plan -out=tfplan
terraform show tfplan
# Apply only after reviewing the complete plan and account / Region:
terraform apply tfplan
```

The root README walkthrough explains login, database bootstrap, Session Manager access, smoke tests and destroy. Never commit `terraform.tfvars`, `backend.hcl`, state, plans, credentials or generated output.

## 5. Important design notes

- The EC2 public IPv4 is used for outbound package installation through the Internet Gateway. The EC2 security group has no ingress rules; do not add SSH or open the app port.
- RDS is private and accepts PostgreSQL only from the EC2 security group.
- The application authenticates to PostgreSQL through RDS IAM DB authentication. A one-time local script uses the RDS-managed master secret over an SSM remote-host port forward to create the `escanor_app` role and sample table. EC2 never receives the master password.
- The S3 Gateway Endpoint policy allows the uploads prefix only. It is not the same as an S3 Interface Endpoint for hybrid / peered-VPC access.
- SSM Interface Endpoints cost per endpoint-hour and data processing. Set `enable_ssm_vpc_endpoints = false` only if you intentionally want SSM to use the public service endpoint over the instance's outbound Internet path.
- RDS backup retention is one day by default, deletion protection is disabled, final snapshot is skipped and S3 force_destroy is enabled for lab teardown. These are deliberately non-production settings.
- The DB storage starts at 20 GiB and may incur cost. Sizing and instance availability must be checked in the selected Region.

## 6. No deployment is performed by CI

The root GitHub Actions workflow and the project CodeBuild buildspec perform app tests and Terraform static validation only. They do not assume a workload deployment role or provision resources. Readers deliberately run the reviewed Terraform commands from their own authenticated workstation.
