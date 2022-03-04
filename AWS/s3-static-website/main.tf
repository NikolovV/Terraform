module "website_s3_bucket" {
  source = "./modules/s3-static-website"

  bucket_name = var.bucket_name

  resource_tags = var.res_tags
}