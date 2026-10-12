output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "private_subnet_cidrs" {
  value = module.vpc.intra_subnets_cidr_blocks
}

output "database_subnet_ids" {
  value = module.vpc.database_subnets
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}
