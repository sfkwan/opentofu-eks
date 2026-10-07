# 2. Declare the data source to fetch available AZs
data "aws_availability_zones" "available" {
  state = "available"

  # Optional: Filter out Local Zones or Wavelength Zones if you only want standard AZs
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.environment}-${var.project}-vpc"

  cidr = var.vpc_cidr

  azs = data.aws_availability_zones.available.names

  public_subnets  = var.public_subnet_cidrs
  private_subnets = var.private_subnet_cidrs

  database_subnets = var.database_subnet_cidrs

  # enable_nat_gateway     = true
  # one_nat_gateway_per_az = true

  enable_dns_support   = true
  enable_dns_hostnames = true

  create_database_subnet_group = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}
