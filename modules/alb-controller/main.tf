# resource "aws_iam_policy" "alb_controller" {

#   name = "${var.cluster_name}-alb-controller"

#   policy = file("${path.module}/iam_policy.json")
# }

data "aws_caller_identity" "current" {

}

module "alb_controller_irsa" {

  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  version = "~> 6.0"
  name    = "${var.cluster_name}-alb-controller"

  attach_load_balancer_controller_policy = true

  oidc_providers = {
    main = {
      provider_arn = var.cluster_oidc_provider_arn

      namespace_service_accounts = [
        "kube-system:aws-load-balancer-controller"
      ]
    }
  }
}

# resource "helm_release" "aws_load_balancer_controller" {
#   name = "aws-load-balancer-controller"

#   # repository = "https://aws.github.io/eks-charts"
#   repository = "oci://${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/helm"
#   version    = "3.6.0"
#   chart      = "aws-load-balancer-controller"

#   namespace = "kube-system"

#   set = [
#     {
#       name  = "clusterName"
#       value = var.cluster_name
#     },
#     {
#       name  = "serviceAccount.create"
#       value = "true"
#     },
#     {
#       name  = "serviceAccount.name"
#       value = "aws-load-balancer-controller"
#       }, {
#       name  = "vpcId"
#       value = var.vpc_id
#     },
#     {
#       name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#       value = module.alb_controller_irsa.arn
#     },
#     {
#       name  = "image.repository"
#       value = "${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/prkwan/aws-load-balancer-controller"
#   }]

# }
