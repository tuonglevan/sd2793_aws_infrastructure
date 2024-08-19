locals {
  role_name = "jenkins"
  ecr_policy = "jenkins_ecr_policy"
  eks_policy = "jenkins_eks_policy"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
	actions = ["sts:AssumeRole"]
	principals {
	  type        = "Service"
	  identifiers = ["ec2.amazonaws.com", "eks.amazonaws.com"]
	}
  }
}

data "aws_iam_policy_document" "ecr_policy" {
  statement {
	actions = [
	  "ecr:GetAuthorizationToken",
	  "ecr:BatchCheckLayerAvailability",
	  "ecr:CompleteLayerUpload",
	  "ecr:GetDownloadUrlForLayer",
	  "ecr:InitiateLayerUpload",
	  "ecr:ListImages",
	  "ecr:PutImage",
	  "ecr:UploadLayerPart"
	]
	resources = ["*"]
	effect = "Allow"
  }
}

data "aws_iam_policy_document" "eks_policy" {
  statement {
	actions = [
	  "eks:DescribeCluster",
	  "eks:ListClusters"
	]
	resources = ["*"]
	effect    = "Allow"
  }
}

resource "aws_iam_role_policy" "jenkins_ecr_policy" {
  name = local.ecr_policy
  role = aws_iam_role.jenkins.id

  policy = data.aws_iam_policy_document.ecr_policy.json
}

resource "aws_iam_role_policy" "jenkins_eks_policy" {
  name = local.eks_policy
  role = aws_iam_role.jenkins.id

  policy = data.aws_iam_policy_document.eks_policy.json
}

resource "aws_iam_instance_profile" "jenkins" {
  name = local.role_name
  role = aws_iam_role.jenkins.name
}

resource "aws_iam_role" "jenkins" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}