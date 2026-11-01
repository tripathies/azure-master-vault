output "aws_account_id" {
  description = "AWS account ID used by this Terraform run."
  value       = data.aws_caller_identity.current.account_id
}
output "aws_region" {
  description = "Deployment Region."
  value       = var.aws_region
}
output "ec2_instance_id" {
  description = "Escanor application EC2 instance ID."
  value       = aws_instance.app.id
}
output "ec2_public_ipv4" {
  description = "Public IPv4 for outbound Internet egress. No inbound security-group rules are configured."
  value       = aws_instance.app.public_ip
}
output "rds_endpoint" {
  description = "Private PostgreSQL endpoint."
  value       = aws_db_instance.escanor.address
}
output "rds_port" {
  description = "PostgreSQL port."
  value       = aws_db_instance.escanor.port
}
output "rds_master_secret_arn" {
  description = "RDS-managed master secret ARN. The local operator uses this to bootstrap the IAM-authenticated application DB role."
  value       = aws_db_instance.escanor.master_user_secret[0].secret_arn
}
output "s3_bucket_name" {
  description = "Private, versioned S3 learning bucket."
  value       = aws_s3_bucket.data.bucket
}
output "s3_gateway_endpoint_id" {
  description = "S3 gateway VPC endpoint ID."
  value       = aws_vpc_endpoint.s3.id
}
output "ssm_interface_endpoint_ids" {
  description = "Systems Manager interface VPC endpoint IDs."
  value       = [for endpoint in aws_vpc_endpoint.ssm : endpoint.id]
}
output "session_manager_connect_command" {
  description = "Open a shell without SSH or an inbound port."
  value       = "aws ssm start-session --target ${aws_instance.app.id} --region ${var.aws_region}"
}
output "application_port_forward_command" {
  description = "Forward the app port to localhost over Session Manager."
  value       = "aws ssm start-session --target ${aws_instance.app.id} --document-name AWS-StartPortForwardingSession --parameters '{\"portNumber\":[\"8080\"],\"localPortNumber\":[\"8080\"]}' --region ${var.aws_region}"
}
