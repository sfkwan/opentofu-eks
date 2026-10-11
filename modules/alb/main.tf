resource "aws_lb" "api" {
  name               = "demo-api-alb"
  load_balancer_type = "application"
  internal           = true
  security_groups = [
    var.security_group_id
  ]
  subnets = var.private_subnet_ids

}

resource "aws_lb_target_group" "api" {
  name        = "demo-api"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    path     = "/actuator/health"
    protocol = "HTTP"
    matcher  = "200"
  }
}

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.api.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
}
