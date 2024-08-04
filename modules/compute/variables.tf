variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to launch. Example: t2.micro"
  default = "t3.micro"
}

variable "subnet_id" {
  type = string
  description = "The subnet ID to launch in"
  nullable = false
}

variable "vpc_security_group_ids" {
  type = list(string)
  nullable = false
}

variable "iam_instance_profile" {
  description = "The IAM instance profile name for the instance"
}