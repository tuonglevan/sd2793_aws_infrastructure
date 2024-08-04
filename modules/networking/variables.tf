variable "vpc_base_name" {
  description = "Base name that will be used as a prefix for VPC-related resources"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type = string
}

variable "public_subnet_ips" {
  description = "List of public subnet IP addresses."
  type = list(string)
}

variable "private_subnet_ips" {
  description = "List of private subnet IP addresses."
  type = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones in the region"
  type        = list(string)
}