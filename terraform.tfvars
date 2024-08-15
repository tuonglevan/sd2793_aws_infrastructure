settings = {
  region = "ap-southeast-1"
}
# Networking
networking = {
  vpc_base_name      = "Devops for Devs"
  create_nat_gateway = true
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  public_subnet_ips  = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  private_subnet_ips = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
}
# ECR
ecr = {
  repository_names = ["backend", "frontend"]
  image_tag_mutability = "IMMUTABLE"
  enable_scan_on_push = true
}
# KeyPair
keypairs = {
  jenkins_keypair_path = "./keypair/ubuntu-jenkins.pub"
  eks_node_keypair_path = "./keypair/ubuntu-eks-node.pub"
}
# Compute
compute = {
  image_id      = "ami-060e277c0d4cce553"
  instance_type = "t3.small"
}
# EKS
eks = {
  cluster_name = "sd2793-devops-eks-cluster",
  cluster_version = "1.30"
  endpoint_public_access = false
  endpoint_private_access = true
  # Node Groups
  managed_node_groups = {
    one = {
      node_group_name  = "node-app"
      subnet_type   = "private"
      image_id      = "ami-02c7bc17d3eb4fd0a" # AL2023_x86_64_STANDARD
      instance_type    = "t3.small"
      ebs_volume_size  = 20
      ebs_volume_type  = "gp3"
      desired_size = 2
      min_size = 2
      max_size = 3
    }
  }
}