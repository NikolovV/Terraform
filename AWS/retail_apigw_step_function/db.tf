module "bank" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = ">= 1.2.2"

  name       = var.db_bank_config["name"]
  hash_key   = var.db_bank_config["hash_key"]
  attributes = var.db_bank_atributes

  tags = var.resource_tags
}

module "shop" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = ">= 1.2.2"

  name       = var.db_shop_config["name"]
  hash_key   = var.db_shop_config["hash_key"]
  attributes = var.db_shop_atributes

  tags = var.resource_tags
}

