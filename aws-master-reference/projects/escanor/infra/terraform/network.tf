resource "aws_vpc" "escanor" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "${local.name}-vpc" }
}
resource "aws_internet_gateway" "escanor" {
  vpc_id = aws_vpc.escanor.id
  tags   = { Name = "${local.name}-igw" }
}
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.escanor.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 1)
  availability_zone       = local.availability_zones[0]
  map_public_ip_on_launch = false
  tags = { Name = "${local.name}-public-a" }
}
resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.escanor.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 11)
  availability_zone       = local.availability_zones[0]
  map_public_ip_on_launch = false
  tags = { Name = "${local.name}-private-a" }
}
resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.escanor.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 12)
  availability_zone       = local.availability_zones[1]
  map_public_ip_on_launch = false
  tags = { Name = "${local.name}-private-b" }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.escanor.id
  tags   = { Name = "${local.name}-public-rt" }
}
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.escanor.id
}
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.escanor.id
  tags   = { Name = "${local.name}-private-a-rt" }
}
resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.escanor.id
  tags   = { Name = "${local.name}-private-b-rt" }
}
resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}
resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_b.id
}
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.escanor.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [
    aws_route_table.public.id,
    aws_route_table.private_a.id,
    aws_route_table.private_b.id
  ]
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "ListEscanorUploads"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:ListBucket"]
        Resource  = aws_s3_bucket.data.arn
        Condition = {
          StringLike = {
            "s3:prefix" = ["uploads/", "uploads/*"]
          }
        }
      },
      {
        Sid       = "ReadWriteEscanorUploads"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject", "s3:PutObject"]
        Resource  = "${aws_s3_bucket.data.arn}/uploads/*"
      }
    ]
  })
  tags = { Name = "${local.name}-s3-gateway-endpoint" }
}
resource "aws_vpc_endpoint" "ssm" {
  for_each = toset(
    var.enable_ssm_vpc_endpoints
    ? concat(["ssm", "ssmmessages"], var.enable_legacy_ec2messages_endpoint ? ["ec2messages"] : [])
    : []
  )
  vpc_id              = aws_vpc.escanor.id
  service_name        = "com.amazonaws.${var.aws_region}.${each.value}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_a.id]
  security_group_ids  = [aws_security_group.vpc_endpoints.id]
  private_dns_enabled = true
  tags = { Name = "${local.name}-${each.value}-endpoint" }
}
