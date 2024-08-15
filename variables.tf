# Basic settings
variable "settings" {
  description = "Basic settings for the infrastructure"
  type        = object({
    region = string
  })
  default = {
    region = "ap-southeast-1"
  }
}

# Networking
variable "networking" {
  description = "Configuration for networking resources"
  type = object({
    vpc_base_name       = string,
    create_nat_gateway  = bool,
    cidr_block          = string,
    public_subnet_ips   = list(string),
    private_subnet_ips  = list(string),
    availability_zones  = list(string)
  })
}

# ECR
variable "ecr" {
  description = "Configuration for ECR repositories"
  type = object({
    repository_names     = list(string),
    image_tag_mutability = string,
    enable_scan_on_push  = bool
  })
  default = {
    repository_names      = [],
    image_tag_mutability  = "IMMUTABLE",
    enable_scan_on_push   = true
  }
}
# KeyPair
variable "keypairs" {
  description = "Paths to SSH key pairs"
  type = object({
    jenkins_keypair_path = string,
    eks_node_keypair_path = string
  })
}
# Compute
variable "compute" {
  description = "Configuration for compute resources"
  type = object({
    image_id      = string,
    instance_type = string
  })
  default = {
    image_id      = "ami-060e277c0d4cce553"
    instance_type = "t3.small"
  }
}
# EKS
variable "eks" {
  description = "Configuration for EKS resources"
  type = object({
    cluster_name = string
    cluster_version = string
    endpoint_private_access = bool
    endpoint_public_access = bool
    # Node Groups
    managed_node_groups = map(object({
      node_group_name   = string
      subnet_type       = string  # "private" or "public"
      image_id          = string
      instance_type     = string
      ebs_volume_size    = number
      ebs_volume_type   = string
      desired_size      = number
      max_size          = number
      min_size          = number
    }))
  })
}