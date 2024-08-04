locals {
  jenkins_role_name = "jenkins"
  jenkins_ecr_policy = "jenkins_ecr_policy"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
	actions = ["sts:AssumeRole"]
	principals {
	  type        = "Service"
	  identifiers = ["ec2.amazonaws.com"]
	}
  }
}

data "aws_iam_policy_document" "ecr_policy" {
  statement {
	actions = [
	  "ecr:GetAuthorizationToken",
	  "ecr:BatchCheckLayerAvailability",
	  "ecr:GetDownloadUrlForLayer",
	  "ecr:GetRepositoryPolicy",
	  "ecr:DescribeRepositories",
	  "ecr:ListImages",
	  "ecr:DescribeImages",
	  "ecr:BatchGetImage",
	  "ecr:GetLifecyclePolicy",
	  "ecr:GetLifecyclePolicyPreview",
	  "ecr:ListTagsForResource",
	  "ecr:DescribeImageScanFindings",
	  "ecr:InitiateLayerUpload",
	  "ecr:UploadLayerPart",
	  "ecr:CompleteLayerUpload",
	  "ecr:PutImage",
	]
	resources = ["*"]
	effect = "Allow"
  }
}

resource "aws_iam_role_policy" "jenkins_ecr_policy" {
  name = local.jenkins_ecr_policy
  role = aws_iam_role.jenkins.id

  policy = data.aws_iam_policy_document.ecr_policy.json
}

resource "aws_iam_instance_profile" "jenkins" {
  name = local.jenkins_role_name
  role = aws_iam_role.jenkins.name
}

resource "aws_iam_role" "jenkins" {
  name               = local.jenkins_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}