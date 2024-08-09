variable "eks_cluster_name" {
  description = "The name of your EKS cluster"
  type        = string
}

variable "eks_cluster_version" {
  description = "Kubernetes version to use for the EKS cluster"
  default     = "1.21"
}

variable "eks_cluster_role_arn" {
  description = "ARN of IAM role that should be used by the EKS cluster"
  type        = string
}

variable "eks_cluster_security_group_ids" {
  description = "List of IDs for the security groups to be associated with the EKS cluster. These security groups are used to control inbound and outbound traffic to the EKS cluster."
  type = list(string)
}

variable "eks_cluster_subnet_ids" {
  type = list(string)
  description = "List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane."
}

variable "eks_cluster_iam_policy_arn" {
  description = "ARN of IAM policy that should be attached to the EKS cluster role"
  type = string
}

variable "endpoint_private_access" {
  type = bool
  default = true
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
}

variable "endpoint_public_access" {
  type = bool
  default = true
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
}

# variable "private_subnet_ids" {
#   type = list(string)
#   description = "List of private subnet IDs."
# }
#
# variable "public_subnet_ids" {
#   type = list(string)
#   description = "List of public subnet IDs."
# }



# variable "node_role_arn" {
#   description = "ARN of the IAM role that should be used by the EKS worker nodes"
#   type        = string
# }