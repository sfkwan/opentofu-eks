variable "db_name" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  sensitive = true
  type      = string
}

variable "db_instance_class" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}