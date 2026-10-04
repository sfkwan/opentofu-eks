output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_primary_sg_id" {
  value = module.eks.cluster_primary_security_group_id
}

