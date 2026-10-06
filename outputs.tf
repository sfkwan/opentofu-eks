output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "database_subnet_ids" {
  value = module.vpc.database_subnet_ids
}

output "eks_sg_id" {
  value = module.security_groups.eks_sg_id
}

output "rds_sg_id" {
  value = module.security_groups.rds_sg_id
}

output "endpoint_sg_id" {
  value = module.security_groups.endpoint_sg_id
}

# output "db_instance_endpoint" {
#   value = module.rds.db_instance_endpoint
# }

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "configure_kubectl" {
  value = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}

output "cluster_primary_sg_id" {
  value = module.eks.cluster_primary_sg_id
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "iam_irsa" {
  value = module.iam_irsa.iam_role_arn
}
