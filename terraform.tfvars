region = "ap-southeast-1"
# Networking
vpc_base_name      = "Devops for Devs"
cidr_block         = "10.0.0.0/16"
availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
public_subnet_ips  = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
private_subnet_ips = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
# ECR
ecr_repos = ["nodejs-backend", "react-frontend"]
image_tag_mutability = "MUTABLE"
enable_scan_on_push = true
# Compute
instance_type = "t2.small"
image_id      = "ami-012c2e8e24e2ae21d"