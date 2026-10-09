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

data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name

  depends_on = [
    module.eks
  ]
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name

  depends_on = [
    module.eks
  ]
}

data "aws_ecr_authorization_token" "helm" {}

data "aws_caller_identity" "current" {

}

provider "helm" {
  kubernetes = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
  registries = [
    {
      url      = "oci://${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com"
      username = data.aws_ecr_authorization_token.helm.user_name
      password = data.aws_ecr_authorization_token.helm.password
    }
  ]
}
