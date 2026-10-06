output "s3_bucket_arn" {
  value = aws_s3_bucket.app_storage.arn
}
output "iam_role_arn" {
  value = module.s3_irsa_role.iam_role_arn
}
