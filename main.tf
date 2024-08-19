provider "aws" {
  region = var.settings.region
}
# IAM Roles
module "jenkins_iam_role" {
  source = "./modules/iam_role/jenkins"
}
# EKS
module "eks_iam_role" {
  source = "./modules/iam_role/eks"
  eks_provider_url = module.eks_cluster_and_worker_nodes.provider_url
}
# Complete VPC creation
module "networking" {
  source             = "./modules/networking"
  region             = var.settings.region
  vpc_base_name      = var.networking.vpc_base_name
  cidr_block         = var.networking.cidr_block
  create_nat_gateway = var.networking.create_nat_gateway
  public_subnet_ips  = var.networking.public_subnet_ips
  private_subnet_ips = var.networking.private_subnet_ips
  availability_zones = var.networking.availability_zones
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
  # EKS
  eks_cluster_name = var.eks.cluster_name
  eks_cluster_sg_name = "${var.eks.cluster_name}-cluster-sg"
  eks_nodes_sg_name = "${var.eks.cluster_name}-node-sg"
}

# KeyPair
module "keypair" {
  source = "./modules/keypair"
  # keypairs
  jenkins_keypair_path = var.keypairs.jenkins_keypair_path
  eks_node_keypair_path = var.keypairs.eks_node_keypair_path
}

# Compute
module "compute" {
  source                 = "./modules/compute"
  image_id               = var.compute.image_id
  instance_type          = var.compute.instance_type
  subnet_id              = module.networking.public_subnet_ids[0]
  vpc_security_group_ids = [module.security.jenkins_sg]
  iam_instance_profile   = module.jenkins_iam_role.instance_profile
  jenkins_key_name       = module.keypair.jenkins
}
# ECR
module "ecr" {
  source = "./modules/ecr"
  repository_names = var.ecr.repository_names
  image_tag_mutability = var.ecr.image_tag_mutability
  enable_scan_on_push = var.ecr.enable_scan_on_push
}
# EKS cluster and worker nodes
module "eks_cluster_and_worker_nodes" {
  source = "./modules/eks"
  # Cluster
  cluster_name = var.eks.cluster_name
  cluster_version = var.eks.cluster_version
  cluster_role_arn = module.eks_iam_role.role_arn.cluster
  cluster_iam_policy_arn = module.eks_iam_role.iam_policy_arn
  cluster_subnet_ids = flatten([module.networking.public_subnet_ids, module.networking.private_subnet_ids])
  cluster_security_group_ids = [module.security.eks_cluster_sg, module.security.eks_node_sg]
  # Network access
  endpoint_public_access = var.eks.endpoint_public_access
  endpoint_private_access = var.eks.endpoint_private_access
  # Subnets
  public_subnet_ids = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
  # Node Groups
  node_role_arn = module.eks_iam_role.role_arn.node_group
  node_ec2_ssh_key_name = module.keypair.eks_node_keypair_path
  managed_node_groups = var.eks.managed_node_groups
  # Addons
  addon_ebs_csi_driver_role_arn = module.eks_iam_role.addons.ebs_csi_driver
}