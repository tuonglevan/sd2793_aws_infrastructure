locals {
  cluster_role_name = "EKSClusterRole"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
	actions = ["sts:AssumeRole"]
	principals {
	  type        = "Service"
	  identifiers = ["eks.amazonaws.com"]
	}
  }
}

resource "aws_iam_role" "eks_cluster" {
  name               = local.cluster_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
#
resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}