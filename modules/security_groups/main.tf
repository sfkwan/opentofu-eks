resource "aws_security_group" "eks" {

  name   = "eks-sg"
  vpc_id = var.vpc_id
  tags = {
    Name = "eks-sg"
  }
}

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

resource "aws_security_group_rule" "rds_from_eks" {
  type = "ingress"

  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"

  security_group_id        = aws_security_group.rds.id
  source_security_group_id = aws_security_group.eks.id
}

resource "aws_security_group_rule" "endpoint_from_eks" {
  type = "ingress"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  security_group_id        = aws_security_group.endpoint.id
  source_security_group_id = aws_security_group.eks.id
}

resource "aws_security_group_rule" "endpoint_from_cluster" {
  type = "ingress"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  security_group_id        = aws_security_group.endpoint.id
  source_security_group_id = var.cluster_primary_sg_id
}