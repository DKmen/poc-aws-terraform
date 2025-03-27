# Define Terraform Version and AWS Provider
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Initialize AWS Provider and set default tags
provider "aws" {
  region = var.aws_region

  access_key = ""
  secret_key = ""

  default_tags {
    tags = {
      Project   = var.aws_project
      ManagedBy = "Terraform"
    }
  }
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_name = "custom-vpc"
  vpc_cidr = "10.0.0.0/16"
}
