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
  name = "cagatayakk"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}



output "registry_id" {
  description = "The account ID of the registry holding the repository."
  value = aws_ecr_repository.devopsyolujenkins.registry_id
}

output "repository_url" {
  description = "The account ID of the registry holding the repository."
  value = aws_ecr_repository.devopsyolujenkins.repository_url
}

