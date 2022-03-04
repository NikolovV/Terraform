module "node_instance" {
  source         = "./modules/server"
  instance_count = 2
  environment_tags = {
    "environment_id" = "development"
  }
}