terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


resource "aws_ecr_repository" "devopsyolujenkins" {
  name = "nginx"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_iam_role" "ec2ecrfullaccess" {
  name = "ecr_ec2_permission"
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ecr-ec2_profile"
  role = aws_iam_role.ec2ecrfullaccess.name
}

output "registry_id" {
  description = "The account ID of the registry holding the repository."
  value = aws_ecr_repository.devopsyolujenkins.registry_id
}

output "repository_url" {
  description = "The account ID of the registry holding the repository."
  value = aws_ecr_repository.devopsyolujenkins.repository_url
}

