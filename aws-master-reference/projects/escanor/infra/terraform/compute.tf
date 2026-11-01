resource "aws_instance" "app" {
  ami                         = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = var.create_public_ipv4_for_ec2
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2.name
  user_data = templatefile("${path.module}/user_data.sh.tftpl", {
    app_py_b64       = filebase64("${path.module}/../../app/app.py")
    index_html_b64   = filebase64("${path.module}/../../app/templates/index.html")
    requirements_b64 = filebase64("${path.module}/../../app/requirements.txt")
    aws_region       = var.aws_region
    db_host          = aws_db_instance.escanor.address
    db_name          = aws_db_instance.escanor.db_name
    db_port          = aws_db_instance.escanor.port
    db_user          = var.db_app_username
    s3_bucket        = aws_s3_bucket.data.bucket
  })
  user_data_replace_on_change = true
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 10
    encrypted             = true
    delete_on_termination = true
  }
  depends_on = [
    aws_iam_role_policy_attachment.ssm_core,
    aws_iam_role_policy.ec2_app,
    aws_vpc_endpoint.s3,
    aws_db_instance.escanor
  ]
  tags = { Name = "${local.name}-app" }
}
