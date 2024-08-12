# Local variables
locals {
  node_group_name = "eks-node-group"
  source_security_ids = ""
  ec2_ssh_key         = ""
}
# Nodes in Private subnet
resource "aws_eks_node_group" "private_subnet" {
  cluster_name    = var.eks_cluster_name
  node_group_name = "${var.eks_node_group_name}-private-subnet"
  node_role_arn   = var.eks_nodes_role_arn
  subnet_ids      = var.private_subnet_ids

  ami_type       = var.ami_type
  disk_size      = var.disk_size
  instance_types = var.instance_types

  scaling_config {
	desired_size = var.pvt_desired_size
	max_size     = var.pvt_max_size
	min_size     = var.pvt_min_size
  }

#   remote_access {
# 	ec2_ssh_key = local.ec2_ssh_key
# 	source_security_group_ids = local.source_security_ids
#   }

  update_config {
	max_unavailable = 1
  }

  tags = {
	Name = "${var.eks_node_group_name}-private-subnet"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
	var.eks_nodes_role_arn
  ]
}