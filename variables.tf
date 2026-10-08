
variable "project" {
  type    = string
  default = "prkwan-eks"
}

variable "owner" {
  type    = string
  default = "platform-team"
}

variable "environment" {
  type        = string
  description = "Environment to create EKS cluster"
  default     = "dev"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}


variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = [
    "10.0.11.0/24",
    "10.0.12.0/24",
    "10.0.13.0/24"
  ]
}

variable "db_subnet_cidrs" {
  type = list(string)
  default = [
    "10.0.21.0/24",
    "10.0.22.0/24",
    "10.0.23.0/24"
  ]
}

variable "eks_cluster_name" {
  type    = string
  default = "prkwan-eks-cluster"
}

variable "k8s_version" {
  type    = string
  default = "1.37"
}
variable "k8s_namespace" {
  type    = string
  default = "my-app-ns"
}

variable "k8s_service_account" {
  type    = string
  default = "s3-service-account"
}

variable "db_name" {
  type    = string
  default = "prkwan-eks-db"
}

variable "db_username" {
  type    = string
  default = "prkwan"
}

variable "db_password" {
  sensitive = true
  type      = string
  default   = "prkwan123"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_port" {
  description = "DB port"
  type        = number
  default     = 5432
}
