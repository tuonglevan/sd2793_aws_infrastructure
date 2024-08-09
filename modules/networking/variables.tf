variable "region" {
  type = string
  default     = "ap-southeast-1"
  description = "The region where resources will be created"
}
variable "vpc_base_name" {
  type        = string
  description = "Base name that will be used as a prefix for VPC-related resources"
}

variable "cidr_block" {
  type = string
  description = "The CIDR block for the VPC."
}

variable "public_subnet_ips" {
  type = list(string)
  description = "List of public subnet IP addresses."
}

variable "private_subnet_ips" {
  type = list(string)
  description = "List of private subnet IP addresses."
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of availability zones in the region"
}

variable "create_nat_gateway" {
  type        = bool
  default     = false
  description = "Set to true to create the NAT gateway, set to false to skip creation"
}