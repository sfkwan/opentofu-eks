variable "vpc_id" {
  type = string

}
variable "cluster_primary_sg_id" {
  description = "The primary security group ID of the EKS cluster"
  type        = string
}