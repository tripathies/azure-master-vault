data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}
data "aws_rds_engine_version" "postgres" {
  engine       = "postgres"
  version      = var.db_engine_major_version
  latest       = true
  default_only = true
}
resource "random_id" "bucket_suffix" {
  byte_length = 4
}
locals {
  name = "${var.name_prefix}-${var.environment}"
  common_tags = merge({
    Project            = "Escanor"
    Environment        = var.environment
    Owner              = var.owner
    ManagedBy          = "Terraform"
    DataClassification = "Synthetic"
    Purpose            = "AWS learning reference"
  }, var.tags)
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)
  s3_bucket_name     = "${local.name}-${data.aws_caller_identity.current.account_id}-${random_id.bucket_suffix.hex}"
}
check "two_available_azs" {
  assert {
    condition     = length(data.aws_availability_zones.available.names) >= 2
    error_message = "The selected Region must expose at least two available Availability Zones for the RDS subnet group."
  }
}
check "aws_account_is_available" {
  assert {
    condition     = length(data.aws_caller_identity.current.account_id) == 12
    error_message = "Unable to determine a 12-digit AWS account ID. Authenticate with an AWS role or SSO profile before planning."
  }
}
