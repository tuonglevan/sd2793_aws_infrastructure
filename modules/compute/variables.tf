variable "image_id" {
  description = "The id of the machine image (AMI) to use for the server."
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance to launch."
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to launch in"
  type = string
  nullable = false
}

variable "vpc_security_group_ids" {
  type = list(string)
  nullable = false
}

variable "iam_instance_profile" {
  description = "The IAM instance profile name for the instance"
}

variable "jenkins_key_name" {
  type = string
  description = "The name of the keypair to use for the instance"
  nullable = false
}