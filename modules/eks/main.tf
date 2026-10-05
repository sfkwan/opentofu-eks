module "eks" {
  source = "terraform-aws-modules/eks/aws"

  version            = "~> 21.0"
  name               = var.cluster_name
  kubernetes_version = "1.37"

  endpoint_public_access  = true
  endpoint_private_access = true

  vpc_id                     = var.vpc_id
  subnet_ids                 = var.private_subnet_ids
  create_security_group      = false
  create_node_security_group = false
  security_group_id          = var.cluster_sg_id

  enable_cluster_creator_admin_permissions = true

  fargate_profiles = {
    default = {
      name = "default"
      selectors = [
        {
          namespace = "my-app-ns"
        },
        {
          namespace = "default"
        },
        {
          namespace = "kube-system"
        }
      ]

    }
  }
}