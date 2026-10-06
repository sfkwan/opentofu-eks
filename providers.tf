provider "aws" {
  region = var.aws_region
  default_tags {
    tags = local.common_tags

  }
}

# Add this to your root main.tf or providers.tf
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the aws-cli to be installed locally
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}
