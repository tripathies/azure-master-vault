# Escanor AWS — Run the build in AWS CodeBuild

Escanor provides two build paths:
- GitHub Actions for automatic pull-request / main-branch validation.
- AWS CodeBuild using the repository's buildspec.

Both paths run application unit tests and Terraform static validation. Neither path runs Terraform plan against a real account or creates AWS resources.

## 1. Buildspec location

The file is:

`aws-master-reference/projects/escanor/buildspec.yml`

When creating a CodeBuild project from the AWS Vault repository, set the Buildspec name to this repository-relative path.

## 2. Recommended CodeBuild project settings

| Setting | Value |
|---|---|
| Source | This GitHub repository |
| Source version | Branch or pull-request ref to validate |
| Environment image | AWS managed Ubuntu 24.04 Standard image (`aws/codebuild/standard:8.0`), x86_64; Python 3.11 runtime is supported |
| Environment compute | Small build environment |
| Privileged mode | Off |
| Service role | Build-only role; no deployment permissions |
| Buildspec | `aws-master-reference/projects/escanor/buildspec.yml` |
| Artifacts | None required for the static validation workflow |
| VPC | Do not attach a VPC for this build-only job unless the organization requires it; dependency downloads need outbound HTTPS |

The build role needs permission to write its CloudWatch Logs and retrieve the source from the configured source connection. It does **not** need EC2, RDS, S3 workload, IAM deployment, CloudFormation or Terraform apply permissions. Select the CodeBuild managed Ubuntu 24.04 Standard 8.0 image explicitly so the `python: 3.11` runtime in the buildspec matches a supported image.

## 3. What the build runs

1. Installs a pinned Terraform CLI release and verifies the Linux AMD64 archive checksum.
2. Installs the pinned Python application requirements.
3. Compiles the Python application.
4. Runs the unit test suite.
5. Runs `terraform fmt -check -recursive`.
6. Runs `terraform init -backend=false`.
7. Runs `terraform validate`.

The Terraform init step does not configure the remote state bucket. The build does not authenticate to an AWS workload account or execute Terraform apply.

## 4. Optional CodePipeline integration

A reader may connect the CodeBuild project to AWS CodePipeline:
1. Source stage: GitHub connection / CodeConnections source.
2. Build stage: the CodeBuild project configured with the buildspec above.
3. No deploy stage is included in this learning pipeline.

This is an optional AWS learning exercise. CodePipeline, CodeBuild and source-connection resources are not created by the Escanor lab Terraform. Review their charges and the CodeBuild project role before enabling the pipeline.
