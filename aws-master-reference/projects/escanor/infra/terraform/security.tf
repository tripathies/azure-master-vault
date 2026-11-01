resource "aws_security_group" "ec2" {
  name_prefix = "${local.name}-ec2-"
  description = "Escanor EC2: no inbound rules; outbound for HTTPS, SSM, S3 and PostgreSQL."
  vpc_id      = aws_vpc.escanor.id
  # No ingress rule is intentional. Use Systems Manager Session Manager.
  egress {
    description = "Outbound traffic for package updates and AWS service connectivity"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "${local.name}-ec2-sg" }
}
resource "aws_security_group" "vpc_endpoints" {
  name_prefix = "${local.name}-vpce-"
  description = "HTTPS from the Escanor EC2 instance to interface endpoints."
  vpc_id      = aws_vpc.escanor.id
  ingress {
    description     = "HTTPS from the Escanor EC2 instance"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }
  tags = { Name = "${local.name}-vpce-sg" }
}
resource "aws_security_group" "rds" {
  name_prefix = "${local.name}-rds-"
  description = "PostgreSQL only from the Escanor EC2 security group."
  vpc_id      = aws_vpc.escanor.id
  ingress {
    description     = "PostgreSQL from the Escanor application instance"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }
  tags = { Name = "${local.name}-rds-sg" }
}
