variable "jenkins_keypair_path" {
  type        = string
  description = "The path to the SSH key pair file. This key pair is used for SSH access to the instances."
}

variable "eks_node_keypair_path" {
  type        = string
  description = "The path to the SSH key pair file. This key pair is used for SSH access to the instances."
}