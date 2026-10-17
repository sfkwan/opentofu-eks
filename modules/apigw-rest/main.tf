# modules/api_gateway/main.tf

# 1. Create the VPC Link to point to the NLB
resource "aws_api_gateway_vpc_link" "nlb_link" {
  name        = "${var.name}-apigw-vpc-link"
  description = "VPC Link pointing to EKS Fargate NLB. Managed by Terraform."
  target_arns = [var.nlb_arn]
}

# 2. REST API Definition
resource "aws_api_gateway_rest_api" "api" {
  name        = "${var.name}-fargate-rest-api"
  description = "REST API Gateway in front of EKS Fargate application."
  
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# 3. Catch-all resource /{proxy+}
resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "{proxy+}"
}

# 4. Proxy Method Configuration (ANY Method)
resource "aws_api_gateway_method" "proxy_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

# 5. Private Integration with NLB via VPC Link
resource "aws_api_gateway_integration" "proxy_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.proxy_method.http_method

  type                    = "HTTP_PROXY" # Forwards request intact
  integration_http_method = "ANY"
  uri                     = "http://${var.nlb_dns_name}:${var.app_port}/{proxy}"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.nlb_link.id

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

# 6. Deployment & Live Stage Publication
resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  depends_on = [
    aws_api_gateway_integration.proxy_integration
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.environment
  xray_tracing_enabled = true
}
