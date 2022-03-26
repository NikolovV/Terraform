module "dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = ">= 1.2.2"

  name     = var.db_config["name"]
  hash_key = var.db_config["hash_key"]

  attributes = var.db_atributes

  tags = var.resource_tags
}