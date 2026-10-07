variable "cluster_name" {
  type = string

}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be created"
  type        = string

}

variable "private_subnet_ids" {
  type = set(string)
}



