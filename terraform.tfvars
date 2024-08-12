region = "ap-southeast-1"
# Networking
vpc_base_name      = "Devops for Devs"
cidr_block         = "10.0.0.0/16"
availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
public_subnet_ips  = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
private_subnet_ips = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
# ECR
ecr_repos = ["backend", "frontend"]
image_tag_mutability = "IMMUTABLE"
enable_scan_on_push = true
# EKS
eks_cluster_name = "devops-eks"
# KeyPair
jenkins_keypair_path = "./keypair/ubuntu-jenkins.pub"
# Compute
instance_type = "t3.small"
image_id      = "ami-060e277c0d4cce553"