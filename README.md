# AWS Terraform Module

This module handles the creation of VPC, EC2, ECR, and EKS resources on AWS using Terraform.

## Prerequisites

- AWS account
- AWS CLI installed and configured
- Terraform 1.9.3 installed

## Modules

- **VPC**: The module provisions a VPC with the necessary subnets, gateway, and route tables.
- **EC2**: The module creates an EC2 instance.
- **ECR**: The module sets up an Elastic Container Registry.
- **EKS**: The module creates an Elastic Kubernetes Service cluster.

## Usage

1. Clone the repository ```git clone https://github.com/tuonglevan/sd2793_aws_infastructure.git```
2. Initialize Terraform
   ```terraform init```
3. Run Terraform apply to create the resources.
   ```terraform apply --var-file "terraform.tfvars"```

After running `terraform apply --var-file "terraform.tfvars"`, you will see the plan and you must type `yes` to proceed with the creation of the resources.

## Variables
You can define variables in a terraform.tfvars file or at the CLI. Below are the expected variables:

- region: AWS region (ie. "ap-southeast-1")
- vpc_base_name: Basename for the VPC
- cidr_block: The CIDR block for the VPC
- availability_zones: Availability zones for the subnets
- public_subnet_ips: IP ranges for the public subnets
- private_subnet_ips: IP ranges for the private subnets
- ecr_repos: Names for the ECR repositories
- image_tag_mutability: Tag mutability setting for the repositories
- enable_scan_on_push: Whether to scan images on push
- instance_type: Type of instance (ie. "t3.small")
- image_id: AWS AMI ID

For example, your terraform.tfvars file might look like:
```region                   = "ap-southeast-1"
vpc_base_name            = "Devops for Devs"
cidr_block               = "10.0.0.0/16"
availability_zones       = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
public_subnet_ips        = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
private_subnet_ips       = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
ecr_repos                = ["nodejs-backend", "react-frontend"]
image_tag_mutability     = "MUTABLE"
enable_scan_on_push      = true
image_id                 = "ami-012c2e8e24e2ae21d"
instance_type            = "t2.small"
```

## Resources Created

This module will create:

- A VPC with necessary subnets, gateway, and route tables
- An EC2 instance
- An ECR repository
- An EKS cluster

**Note:** Make sure to review and update the variables in the `main.tf` as per your requirement.