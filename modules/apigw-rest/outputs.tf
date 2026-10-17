output "invoke_url" {
  value = "${aws_api_gateway_stage.stage.invoke_url}/{proxy}"
}

output "stage_arn"{
  value = aws_api_gateway_stage.stage.arn
}