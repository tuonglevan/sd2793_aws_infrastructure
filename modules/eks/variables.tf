variable "cluster_name" {
  description = "The name of your EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "ARN of IAM role that should be used by the EKS cluster"
  type        = string
}

variable "cluster_iam_policy_arn" {
  description = "ARN of IAM policy that should be attached to the EKS cluster role"
  type = string
}

variable "cluster_security_group_ids" {
  description = "List of IDs for the security groups to be associated with the EKS cluster. These security groups are used to control inbound and outbound traffic to the EKS cluster."
  type = list(string)
}

variable "cluster_subnet_ids" {
  type = list(string)
  description = "List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane."
}

variable "endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type = bool
}

variable "endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
  type = bool
}

variable "private_subnet_ids" {
  type = list(string)
  description = "List of private subnet IDs."
}

variable "public_subnet_ids" {
  type = list(string)
  description = "List of public subnet IDs."
}

# Node Groups
variable "node_role_arn" {
  description = "The ARN of the IAM role for the EKS nodes"
  type        = string
}

variable "node_ec2_ssh_key_name" {
  description = "SSH key name for EC2 instances"
  type        = string
}

variable "managed_node_groups" {
  description = "Configuration for each node group."
  type = map(object({
    node_group_name   = string
    subnet_type       = string  # "private" or "public"
    image_id          = string
    instance_type     = string
    ebs_volume_size   = number
    ebs_volume_type   = string
    desired_size      = number
    max_size          = number
    min_size          = number
  }))
}
# Addons
variable "addon_ebs_csi_driver_role_arn" {
  description = "The ARN of the IAM role used by the EBS CSI Driver addon for the EKS cluster. This role provides the necessary permissions for the EBS CSI Driver to operate correctly, such as provisioning, managing, and deleting EBS volumes."
  type        = string
}