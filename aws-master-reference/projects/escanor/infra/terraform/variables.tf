variable "aws_region" {
  description = "AWS Region for the Escanor learning lab."
  type        = string
  default     = "ap-south-1"
}
variable "name_prefix" {
  description = "Lowercase resource name prefix."
  type        = string
  default     = "escanor"
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,15}$", var.name_prefix))
    error_message = "name_prefix must start with a lowercase letter and contain 2-16 lowercase letters, digits or hyphens."
  }
}
variable "environment" {
  description = "Environment tag and resource-name suffix."
  type        = string
  default     = "lab"
}
variable "owner" {
  description = "Owner tag. Set this to a team alias, not a personal email."
  type        = string
  default     = "learning"
}
variable "vpc_cidr" {
  description = "IPv4 CIDR block for the learning VPC."
  type        = string
  default     = "10.40.0.0/16"
}
variable "ec2_instance_type" {
  description = "Small EC2 instance class for the learning application."
  type        = string
  default     = "t3.micro"
}
variable "db_instance_class" {
  description = "Small Single-AZ RDS instance class for the lab."
  type        = string
  default     = "db.t4g.micro"
}
variable "db_engine_major_version" {
  description = "PostgreSQL major version selected from currently available default minor versions."
  type        = string
  default     = "16"
}
variable "db_allocated_storage_gib" {
  description = "Initial encrypted RDS storage in GiB."
  type        = number
  default     = 20
  validation {
    condition     = var.db_allocated_storage_gib >= 20 && var.db_allocated_storage_gib <= 100
    error_message = "The lab storage size must be between 20 and 100 GiB."
  }
}
variable "enable_ssm_vpc_endpoints" {
  description = "Create AWS PrivateLink interface endpoints for Systems Manager. These endpoints incur hourly and data-processing charges."
  type        = bool
  default     = true
}
variable "enable_legacy_ec2messages_endpoint" {
  description = "Create ec2messages for Regions/agents that still use the legacy message service."
  type        = bool
  default     = true
}
variable "db_app_username" {
  description = "PostgreSQL application user created by scripts/bootstrap-db-user.py."
  type        = string
  default     = "escanor_app"
  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9_]{0,30}$", var.db_app_username))
    error_message = "db_app_username must be a valid simple PostgreSQL role name."
  }
}
variable "db_backup_retention_days" {
  description = "Automated backup retention. One day is a minimal lab setting, not a production policy."
  type        = number
  default     = 1
  validation {
    condition     = var.db_backup_retention_days >= 0 && var.db_backup_retention_days <= 7
    error_message = "For this learning lab, backup retention must be between 0 and 7 days."
  }
}
variable "create_public_ipv4_for_ec2" {
  description = "Assign a public IPv4 to EC2 for outbound Internet access through the Internet Gateway. No inbound security-group rules are created."
  type        = bool
  default     = true
}
variable "tags" {
  description = "Additional tags applied to all supported resources."
  type        = map(string)
  default     = {}
}
