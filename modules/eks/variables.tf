variable "eks_cluster_name" {
  description = "The name of your EKS cluster"
  type        = string
}

variable "eks_node_group_name" {
  type = string
  description = "Name of the Node Group"
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

variable "private_subnet_ids" {
  type = list(string)
  description = "List of private subnet IDs."
}

variable "public_subnet_ids" {
  type = list(string)
  description = "List of public subnet IDs."
}

# Node Groups
variable "eks_nodes_role_arn" {
  description = "The ARN of the IAM role for the EKS nodes"
  type        = string
}

variable "aws_eks_worker_node_policy_attachment" {
  description = "The ARN of the AWS EKS Worker Node Policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

variable "ec2_read_only_policy_attachment" {
  description = "The ARN of the EC2 Read Only Policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

variable "aws_eks_cni_policy_attachment" {
  description = "The ARN of the AWS EKS CNI Policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

variable "ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU."
  type = string
  default = "AL2_x86_64"
}

variable "disk_size" {
  type = number
  default = 20
  description = "Disk size in GiB for worker nodes. Defaults to 20."
}

variable "instance_types" {
  type = list(string)
  default = ["t3.small"]
  description = "Set of instance types associated with the EKS Node Group."
}

variable "pvt_desired_size" {
  type = number
  default = 1
  description = "Desired number of worker nodes in private subnet"
}

variable "pvt_max_size" {
  type = number
  default = 1
  description = "Maximum number of worker nodes in private subnet."
}

variable "pvt_min_size" {
  type = number
  default = 1
  description = "Minimum number of worker nodes in private subnet."
}