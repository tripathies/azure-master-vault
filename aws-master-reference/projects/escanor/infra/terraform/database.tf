resource "aws_db_subnet_group" "escanor" {
  name       = "${local.name}-db-subnets"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]
  tags = { Name = "${local.name}-db-subnets" }
}
resource "aws_db_instance" "escanor" {
  identifier                          = "${local.name}-postgres"
  engine                              = "postgres"
  engine_version                      = data.aws_rds_engine_version.postgres.version_actual
  instance_class                      = var.db_instance_class
  allocated_storage                   = var.db_allocated_storage_gib
  storage_type                        = "gp3"
  storage_encrypted                   = true
  db_name                             = "escanor"
  username                            = "escanor_admin"
  manage_master_user_password         = true
  iam_database_authentication_enabled = true
  db_subnet_group_name   = aws_db_subnet_group.escanor.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  multi_az               = false
  backup_retention_period    = var.db_backup_retention_days
  auto_minor_version_upgrade = true
  apply_immediately          = true
  deletion_protection        = false
  skip_final_snapshot        = true
  copy_tags_to_snapshot      = true
  tags = { Name = "${local.name}-postgres" }
}
