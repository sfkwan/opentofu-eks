output "rds_sg_id" {
  value = aws_security_group.rds.id
}

output "endpoint_sg_id" {
  value = aws_security_group.endpoint.id
}
# output "alb_sg_id" {
#   value = aws_security_group.alb.id
# }

output "vpc_link_sg_id" {
  value = aws_security_group.vpc_link.id
}
