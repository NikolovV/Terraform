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
  region  = var.aws-region
}

resource "aws_vpc" "terr_vpc" {
  cidr_block = var.cidr-block // terraform apply -var "cidr-block=type_yout_IP"
  instance_tenancy = "default"
  tags = {
    Name = "terraform-vpc" // give name to resource

    // Add tags to resource
    Terraform = "True"
    Project = "Sample-vpc"
  }
}

resource "aws_subnet" "terr-public-sb" {
  vpc_id     = aws_vpc.terr_vpc.id
  cidr_block = "10.1.1.0/24"

  availability_zone = var.alz[0]
}

resource "aws_subnet" "terr-private-sb" {
  vpc_id     = aws_vpc.terr_vpc.id
  cidr_block = "10.1.2.0/24"

  availability_zone = var.alz[1]
}