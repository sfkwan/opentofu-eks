module "http_api" {

  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 6.0"

  name          = "crud-api"
  description   = "REST API for EKS Fargate"
  protocol_type = "HTTP"

  create_stage = true

  stage_name         = "$default"
  create_domain_name = false

  vpc_links = {
    eks = {
      name               = "eks-link"
      security_group_ids = [var.security_group_id]
      subnet_ids         = var.private_subnet_ids
    }
  }

  routes = {
    "$default" = {
      integration = {

        connection_type = "VPC_LINK"
        vpc_link_key    = "eks"
        type            = "HTTP_PROXY"
        method          = "ANY"
        uri             = var.alb_listener_arn
      }
    }
  }

}
