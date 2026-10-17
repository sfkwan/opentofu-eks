output "target_group_arn" {
  value = aws_lb_target_group.api.arn
}

output "listener_arn" {
  value = aws_lb_listener.http.arn
}

output "dns_name" {
  value = aws_lb.api.dns_name
  
}

output "alb_arn" {
  value = aws_lb.api.arn
}

output "nlb_arn" {
  value = aws_lb.api.arn
}

output "nlb_dns_name" {
  value = aws_lb.api.dns_name
}

output "nlb_listener_port" {
  value = aws_lb_listener.http.port
} 