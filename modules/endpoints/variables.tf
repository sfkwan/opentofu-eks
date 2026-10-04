variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "endpoint_sg_id" {
  type = string
}

variable "private_route_table_ids" {
  type = list(string)
}