provider "aws" {
  region = var.region
}
# IAM Roles
module "jenkins_iam_role" {
  source = "./modules/iam_role/jenkins"
}
# EKS
module "eks_iam_role" {
  source = "./modules/iam_role/eks"
  eks_cluster_name = var.eks_cluster_name
}

# Complete VPC creation
module "networking" {
  source             = "./modules/networking"
  region = var.region
  vpc_base_name      = var.vpc_base_name
  cidr_block         = var.cidr_block
  public_subnet_ips  = var.public_subnet_ips
  private_subnet_ips = var.private_subnet_ips
  availability_zones = var.availability_zones
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
  # EKS
  eks_cluster_name = var.eks_cluster_name
  eks_cluster_sg_name = "${var.eks_cluster_name}-cluster-sg"
  eks_nodes_sg_name = "${var.eks_cluster_name}-node-sg"
}
# KeyPair
module "keypair" {
  source = "./modules/keypair"
  jenkins_keypair_path = var.jenkins_keypair_path
}

# Compute
module "compute" {
  source                 = "./modules/compute"
  image_id               = var.image_id
  instance_type          = var.instance_type
  subnet_id              = module.networking.public_subnet_ids[0]
  vpc_security_group_ids = [module.security.jenkins_sg]
  iam_instance_profile   = module.jenkins_iam_role.instance_profile
  jenkins_key_name       = module.keypair.jenkins
}

module "ecr" {
  source = "./modules/ecr"
  ecr_repos = var.ecr_repos
  enable_scan_on_push = var.enable_scan_on_push
  image_tag_mutability = var.image_tag_mutability
}

# module "eks_cluster_and_worker_nodes" {
#   source = "./modules/eks"
#   # EKS Cluster
#   eks_cluster_name = var.eks_cluster_name
#   eks_cluster_role_arn = module.eks_iam_role.role_arn
#   eks_cluster_security_group_ids = [module.security.eks_cluster_sg, module.security.eks_node_sg]
#   eks_cluster_iam_policy_arn = module.eks_iam_role.iam_policy_arn
#   eks_cluster_subnet_ids = flatten([module.networking.public_subnet_ids, module.networking.private_subnet_ids])
#   # EKS node/worker
# }


# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 20.0"
#
#   cluster_version = "1.30"
#   cluster_name    = "devops-eks-cluster"
#
#   cluster_endpoint_public_access  = true
#
#   cluster_addons = {
#     coredns                = {}
#     eks-pod-identity-agent = {}
#     kube-proxy             = {}
#     vpc-cni                = {}
#   }
#
#   vpc_id          = module.networking.vpc_id  # Update to your VPC ID
#   subnet_ids      = module.networking.private_subnet_ids
#
#   eks_managed_node_groups = {
#     eks_nodes = {
#       ami_type       = "AL2023_x86_64_STANDARD"
#       instance_types = ["t3.small"]
#       desired_capacity = 2
#       max_capacity     = 2
#       min_capacity     = 1
#     }
#   }
#
#   # Cluster access entry
#   # To add the current caller identity as an administrator
#   enable_cluster_creator_admin_permissions = true
#
#   tags = {
#     Environment = "dev"
#     Terraform   = "true"
#   }
# }