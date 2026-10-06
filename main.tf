module "vpc" {
  source = "./modules/vpc"

  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  azs         = var.azs

  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs

  project = var.project
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id                = module.vpc.vpc_id
  cluster_primary_sg_id = module.eks.cluster_primary_sg_id
}

module "endpoints" {
  source = "./modules/endpoints"

  region                  = var.aws_region
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnet_ids
  endpoint_sg_id          = module.security_groups.endpoint_sg_id
  private_route_table_ids = module.vpc.private_route_table_ids
}

module "eks" {
  source = "./modules/eks"

  cluster_name       = var.eks_cluster_name
  private_subnet_ids = module.vpc.private_subnet_ids

  vpc_id        = module.vpc.vpc_id
  cluster_sg_id = module.security_groups.eks_sg_id
}

module "iam_irsa" {
  source = "./modules/iam_irsa"

  environment         = var.environment
  cluster_oidc_arn    = module.eks.oidc_provider_arn
  k8s_namespace       = var.k8s_namespace
  k8s_service_account = var.k8s_service_account
}

# module "rds" {
#   source = "./modules/rds"

#   db_name  = var.db_name
#   username = var.db_username
#   password = var.db_password

#   db_instance_class = var.db_instance_class

#   subnet_ids = module.vpc.database_subnet_ids

#   security_group_id = module.security_groups.rds_sg_id
# }