module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.cidr-block
  create_igw = false

  azs             = var.avlz
  public_subnets  = var.publ_sub_cidr

  tags = var.resource_tags
}