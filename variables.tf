variable "region" {
  type        = string
  description = "The region where resources will be created"
  default     = "ap-southeast-1"
}

# Networking
variable "vpc_base_name" {
  description = "Base name that will be used as a prefix for VPC-related resources"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnet_ips" {
  description = "List of public subnet IP addresses."
  type        = list(string)
}

variable "private_subnet_ips" {
  description = "List of private subnet IP addresses."
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones in the region"
  type        = list(string)
}

# ECR
variable "ecr_repos" {
  description = "List of repositories"
  type        = list(string)
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository"
  type        = string
}

variable "enable_scan_on_push" {
  type        = bool
  description = "Enable vulnerability scanning on push to ECR"
  default     = true
}

# Compute
variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to launch. Example: t2.small"
  default     = "t3.small"
}

# variable "keypair_path" {
#   type = string
#   default = "./keypair/udemy-key.pub"
# }