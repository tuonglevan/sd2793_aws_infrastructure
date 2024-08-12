variable "vpc_id" {
  type = string
  description = "The VPC ID"
  nullable = false
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type = string
}

variable "eks_cluster_sg_name" {
  description = "Name of the EKS cluster Security Group"
  type        = string
  default = "eks_cluster_sg"
}

variable "eks_nodes_sg_name" {
  description = "Name of the EKS node group Security Group"
  type        = string
  default = "eks_node_sg"
}