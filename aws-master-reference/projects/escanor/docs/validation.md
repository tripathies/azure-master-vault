# Escanor AWS — Validation and Evidence Checklist

**Status:** Acceptance tests for a reader-managed AWS deployment  
**Deployment:** Not performed by this repository change

## 1. Account and preflight

- [ ] AWS IAM Identity Center / approved role login succeeds.
- [ ] `aws sts get-caller-identity` returns the intended disposable account.
- [ ] Region is approved and required services / instance classes are available.
- [ ] No workload is being created in the Organizations management, Audit or Log Archive account.
- [ ] Budget and cost alerts have named recipients.

## 2. Terraform

- [ ] State bucket is versioned, encrypted and public-access blocked.
- [ ] Terraform init uses the intended `backend.hcl`.
- [ ] `terraform fmt -check -recursive` passes.
- [ ] `terraform validate` passes.
- [ ] Plan is reviewed for account, Region, instance classes, network rules and resource deletion.
- [ ] State, plan, variable files and backend configuration are not committed.

## 3. Network and compute

- [ ] VPC DNS support and DNS hostnames are enabled.
- [ ] Public route table has a default route to the Internet Gateway.
- [ ] Private RDS subnets have no default Internet / NAT route.
- [ ] EC2 is managed by Systems Manager.
- [ ] EC2 security group has no ingress rules.
- [ ] IMDSv2 is required.
- [ ] EC2 user data installs the app and the systemd service is active.
- [ ] Session Manager shell and app-port forwarding work without SSH.
- [ ] Public IPv4 is used for outbound package download only; no app ingress is enabled.

## 4. RDS and private connectivity

- [ ] RDS status is available and `publicly_accessible` is false.
- [ ] DB subnet group spans two private Availability Zones.
- [ ] RDS security group permits TCP 5432 only from the EC2 security group.
- [ ] Operator can reach the database through SSM remote-host port forwarding.
- [ ] RDS master secret is stored in Secrets Manager and is not copied to EC2.
- [ ] The `escanor_app` role has `rds_iam` and expected table permissions.
- [ ] EC2 IAM policy permits `rds-db:connect` only for the intended DB resource/user.
- [ ] Application verifies the RDS TLS certificate using the AWS RDS global CA bundle.

## 5. S3 and VPC endpoints

- [ ] S3 bucket blocks all public access.
- [ ] Bucket-owner-enforced object ownership is enabled.
- [ ] Default encryption and versioning are enabled.
- [ ] Bucket policy denies non-TLS transport.
- [ ] S3 Gateway Endpoint is associated with the public and private route tables.
- [ ] Endpoint policy permits only the Escanor upload-prefix actions.
- [ ] App can upload and list objects through the S3 SDK.
- [ ] Re-uploading the same object name creates a new object version.
- [ ] App can list object versions.
- [ ] Systems Manager interface endpoints resolve through private DNS and allow HTTPS from EC2.
- [ ] Endpoint security group does not permit broad inbound sources.

## 6. Application and IAM

- [ ] `GET /healthz` returns success.
- [ ] Diagnostics show RDS and S3 access success.
- [ ] A note can be inserted into RDS and retrieved.
- [ ] An S3 object can be uploaded and listed.
- [ ] Invalid file names / traversal paths are rejected.
- [ ] No static AWS credentials or DB master password are present in source or EC2 app environment.
- [ ] EC2 uses the instance profile, not a local credentials file.
- [ ] Unit tests pass in CI.

## 7. Cleanup

- [ ] Destroy plan reviewed before apply.
- [ ] EC2, RDS and VPC endpoints removed by Terraform.
- [ ] S3 objects and all versions removed as intended by the lab's force-destroy setting.
- [ ] EBS volumes, snapshots, public IPv4 allocations and any retained resources inspected.
- [ ] State bucket intentionally retained or separately removed only after state is no longer needed.
- [ ] Cost Explorer reviewed after billing data refresh.

## 8. Evidence record

| Field | Value |
|---|---|
| Git commit / release | |
| AWS account ID | |
| Region | |
| Authenticated identity | |
| Terraform version | |
| Provider lockfile version | |
| EC2 instance ID | |
| RDS DB identifier | |
| S3 bucket name | |
| Test date | |
| Result | Pass / Fail / Blocked |
| Evidence location | |
| Reviewer | |
