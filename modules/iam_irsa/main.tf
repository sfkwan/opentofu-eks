# Secure data bucket for workloads
resource "aws_s3_bucket" "app_storage" {
  bucket        = "app-data-storage-${var.environment}-bucket"
  force_destroy = true
}

# IAM Role mapping for Service Accounts (IRSA)
module "s3_irsa_role" {
  source           = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version          = "~> 5.0"
  role_name        = "eks-s3-reader-irsa-role"
  role_description = "Allows Fargate pods to read to S3"

  oidc_providers = {
    main = {
      provider_arn               = var.cluster_oidc_arn
      namespace_service_accounts = ["${var.k8s_namespace}:${var.k8s_service_account}"]
    }
  }



}

# Attach explicit least-privilege read policy to the identity token role
resource "aws_iam_role_policy" "s3_read_access" {
  name = "EKSFargateS3ReadAccess"
  role = module.s3_irsa_role.iam_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ]
        Resource = ["*"]
      }
      # Tip: If your pods require write capabilities, append s3:PutObject here
    ]
  })
}
