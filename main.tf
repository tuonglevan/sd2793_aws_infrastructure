provider "aws" {
  region = var.region
}

# Complete VPC creation
module "networking" {
  source             = "./modules/networking"
  vpc_base_name      = var.vpc_base_name
  cidr_block         = var.cidr_block
  public_subnet_ips  = var.public_subnet_ips
  private_subnet_ips = var.private_subnet_ips
  availability_zones = var.availability_zones
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

module "iam_role" {
  source = "./modules/iam_role"
}

module "compute" {
  source                 = "./modules/compute"
  image_id               = var.image_id
  instance_type          = var.instance_type
  subnet_id              = module.networking.public_subnet_ids[0]
  vpc_security_group_ids = [module.security.jenkins_sg]
  iam_instance_profile   = module.iam_role.jenkins_instance_profile
}

module "ecr" {
  source = "./modules/ecr"
  ecr_repos = var.ecr_repos
  enable_scan_on_push = var.enable_scan_on_push
  image_tag_mutability = var.image_tag_mutability
}

# module "eks" {
#   source = "./modules/eks"
#
#   // Specify required arguments
# }