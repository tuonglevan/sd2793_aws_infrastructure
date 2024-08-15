data "external" "max_pods_calculator" {
  for_each = var.managed_node_groups
  program = ["bash", "${path.module}/scripts/max-pods-calculator.sh"]
  query = {
	instance_type = each.value.instance_type
  }
}

locals {
  max_pods = { for k, v in data.external.max_pods_calculator : k => tonumber(v.result.max_pods) }
  subnet_ids = {
	for name, config in var.managed_node_groups :
	name => (config.subnet_type == "private" ? var.private_subnet_ids : var.public_subnet_ids)
  }
  node_tags = {
	for name, config in var.managed_node_groups :
	name => {
	  Name    = config.node_group_name
	  Cluster = var.cluster_name
	}
  }
}

# Define the launch template for the node group
resource "aws_launch_template" "eks" {
  for_each = var.managed_node_groups

  name_prefix   = "${each.value.node_group_name}-lt"
  image_id      = each.value.image_id
  instance_type = each.value.instance_type

  # Additional configurations for the launch template
  key_name = var.node_ec2_ssh_key_name

  # Additional configurations for the launch template
  block_device_mappings {
	device_name = "/dev/sda1"
	ebs {
	  volume_size = each.value.ebs_volume_size # EBS Volume size
	  volume_type = each.value.ebs_volume_type # EBS Volume type
	  delete_on_termination = true # Delete EBS volume on instance termination
	}
  }

  user_data = base64encode(templatefile("${path.module}/scripts/eks-bootstrap.sh", {
	cluster_name = var.cluster_name
	b64_cluster_ca = aws_eks_cluster.eks_cluster.certificate_authority.0.data
	api_server_url = aws_eks_cluster.eks_cluster.endpoint
	image_id = each.value.image_id
	instance_type = each.value.instance_type
	node_group_name = each.value.node_group_name
	max_pods = local.max_pods[each.key]
  }))

  tag_specifications {
	resource_type = "instance"
	tags = local.node_tags[each.key]
  }
}

# Nodes in Subnet
resource "aws_eks_node_group" "node_groups" {
  for_each = var.managed_node_groups

  cluster_name    = var.cluster_name
  node_group_name = each.value.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = local.subnet_ids[each.key]

  launch_template {
	id      = aws_launch_template.eks[each.key].id
	version = "$Latest"
  }

  scaling_config {
	desired_size = each.value.desired_size
	max_size     = each.value.max_size
	min_size     = each.value.min_size
  }

  update_config {
	max_unavailable = 1
  }

  tags = local.node_tags[each.key]

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
	aws_eks_cluster.eks_cluster,
	var.node_role_arn
  ]
}