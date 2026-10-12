locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project
    Owner       = var.owner
    ManagedBy   = "Terraform"
    Terraform   = "true"
  }
}
