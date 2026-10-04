locals {
  endpoints = [
    "ecr.api",
    "ecr.dkr",
    "logs",
    "monitoring",
    "sts"
  ]
}

resource "aws_vpc_endpoint" "interface" {
  for_each = toset(local.endpoints)

  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.region}.${each.value}"
  vpc_endpoint_type  = "Interface"
  security_group_ids = [var.endpoint_sg_id]
  subnet_ids         = var.subnet_ids

  private_dns_enabled = true

  tags = {
    Name = "${each.value}"
  }
}

resource "aws_vpc_endpoint" "s3" {

  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${var.region}.s3"

  vpc_endpoint_type = "Gateway"

  route_table_ids = var.private_route_table_ids

  tags = {
    Name = "s3-gateway-endpoint"
  }
}