module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  version              = "2.77.0"
  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = var.public_subnets
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_security_group" "rds" {
  name   = var.security_group_name
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = var.sg_ingress["from_port"]
    to_port     = var.sg_ingress["to_port"]
    protocol    = var.sg_ingress["protocol"]
    cidr_blocks = var.whitelist
  }

  egress {
    from_port   = var.sg_ingress["from_port"]
    to_port     = var.sg_ingress["to_port"]
    protocol    = var.sg_ingress["protocol"]
    cidr_blocks = var.whitelist
  }

  tags = var.resource_tags
}