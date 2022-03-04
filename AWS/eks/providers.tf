terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

# Utility provider for interacting with generic HTTP servers as part of a Terraform configuration.
provider "http" {

}