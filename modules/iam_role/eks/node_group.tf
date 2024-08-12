locals {
  node_role_name = "EKSNodeRole"
}

data "aws_iam_policy_document" "assume_workers" {
  statement {
	effect = "Allow"

	actions = ["sts:AssumeRole"]

	principals {
	  type        = "Service"
	  identifiers = ["ec2.amazonaws.com"]
	}
  }
}

resource "aws_iam_role" "eks_nodes" {
  name                 = local.node_role_name

  assume_role_policy = data.aws_iam_policy_document.assume_workers.json
}

resource "aws_iam_role_policy_attachment" "aws_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "aws_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "ec2_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}