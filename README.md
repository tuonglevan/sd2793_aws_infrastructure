# AWS Terraform Module

This module handles the creation of VPC, EC2, ECR, and EKS resources on AWS using Terraform.

## Prerequisites

- AWS account
- AWS CLI installed and configured
- Terraform 0.15.x installed

## Modules

- **VPC**: The module provisions a VPC with the necessary subnets, gateway, and route tables.
- **EC2**: The module creates an EC2 instance.
- **ECR**: The module sets up an Elastic Container Registry.
- **EKS**: The module creates an Elastic Kubernetes Service cluster.

## Usage

1. Clone the repository ```git clone https://github.com/TuongLeVan/sd2793_aws_infastructure.git```
2. Change into the directory
```cd terraform```
3. Initialize Terraform
```terraform init```
4. Run Terraform apply to create the resources.
```terraform apply```

After running `terraform apply`, you will see the plan and you must type `yes` to proceed with the creation of the resources.

## Resources Created

This module will create:

- A VPC with necessary subnets, gateway, and route tables
- An EC2 instance
- An ECR repository
- An EKS cluster

**Note:** Make sure to review and update the variables in the `main.tf` as per your requirement.