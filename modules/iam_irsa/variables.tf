variable "environment" {
  type = string
}

variable "cluster_oidc_arn" {
  type = string
}

variable "k8s_namespace" {
  type = string
}
variable "k8s_service_account" {
  type = string
}