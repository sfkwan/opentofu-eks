resource "aws_security_group" "rds" {
  name   = "rds-sg"
  vpc_id = var.vpc_id
  tags = {
    Name = "rds-sg"
  }
}

resource "aws_security_group" "endpoint" {

  name   = "endpoint-sg"
  vpc_id = var.vpc_id
  tags = {
    Name = "endpoint-sg"
  }
}

resource "aws_security_group" "vpc_link" {

  name   = "vpc-link-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "vpc-link-sg"
  }
}

# resource "aws_vpc_security_group_ingress_rule" "alb_https" {

#   security_group_id = aws_security_group.alb.id

#   referenced_security_group_id = aws_security_group.vpc_link.id

#   from_port = 443
#   to_port   = 443

#   ip_protocol = "tcp"
# }


resource "aws_vpc_security_group_ingress_rule" "rds_from_eks" {

  from_port = var.db_port
  to_port   = var.db_port

  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = var.cluster_primary_sg_id

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "endpoint_from_eks" {

  from_port = 443
  to_port   = 443

  security_group_id            = aws_security_group.endpoint.id
  referenced_security_group_id = var.cluster_primary_sg_id

  ip_protocol = "tcp"

}

# resource "aws_security_group" "alb" {
#   name        = "alb-sg"
#   description = "ALB Security Group"
#   vpc_id      = var.vpc_id

#   tags = {
#     Name = "alb-sg"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "alb_http" {

#   security_group_id = aws_security_group.alb.id

#   cidr_ipv4 = "0.0.0.0/0"

#   from_port   = 80
#   to_port     = 80
#   ip_protocol = "tcp"
# }

# resource "aws_vpc_security_group_ingress_rule" "alb_https" {

#   security_group_id = aws_security_group.alb.id

#   cidr_ipv4 = "0.0.0.0/0"

#   from_port   = 443
#   to_port     = 443
#   ip_protocol = "tcp"
# }
