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

resource "aws_security_group" "eks" {

  name   = "eks-sg"
  vpc_id = var.vpc_id
  tags = {
    Name = "eks-sg"
  }
}

resource "aws_security_group" "vpc_link" {

  name   = "vpc-link-sg"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-link-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc_link_to_alb" {


  security_group_id            = aws_security_group.alb.id
  referenced_security_group_id = aws_security_group.vpc_link.id
  
  ip_protocol = "-1"
}

# resource "aws_vpc_security_group_ingress_rule" "alb_to_eks" {


#   security_group_id            = var.cluster_primary_sg_id
#   referenced_security_group_id = aws_security_group.alb.id

#   ip_protocol = "-1"
# }

# resource "aws_vpc_security_group_ingress_rule" "eks_to_rds" {

#   from_port = var.db_port
#   to_port   = var.db_port

#   security_group_id            = aws_security_group.rds.id
#   referenced_security_group_id = var.cluster_primary_sg_id

#   ip_protocol = "tcp"
# }

# resource "aws_vpc_security_group_ingress_rule" "eks_to_endpoint" {

#   from_port = 443
#   to_port   = 443

#   security_group_id            = aws_security_group.endpoint.id
#   referenced_security_group_id = var.cluster_primary_sg_id

#   ip_protocol = "tcp"

# }

resource "aws_security_group" "alb" {
  name        = "alb-sg"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {

  security_group_id = aws_security_group.alb.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "alb_egress" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol = "-1"

}


