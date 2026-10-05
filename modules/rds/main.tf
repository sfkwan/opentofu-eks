module "rds" {

  source = "terraform-aws-modules/rds/aws"

  version = "~> 7.0"

  identifier = "application-db"

  engine               = "postgres"
  engine_version       = "18.6"
  family               = "postgres18" # DB parameter group
  major_engine_version = "18"         # DB option group
  instance_class       = var.db_instance_class

  allocated_storage = 10

  db_name     = var.db_name
  username    = var.username
  password_wo = var.password

  multi_az = true

  storage_encrypted = true

  subnet_ids = var.subnet_ids

  vpc_security_group_ids = [
    var.security_group_id
  ]

  backup_retention_period = 30

  deletion_protection = true
}