output "website_bucket_name" {
  description = "Name (id) of the bucket"
  value       = module.website_s3_bucket.name
}

output "object_url" {
  description = "Name (id) of the bucket"
  value       = format("http://%s.%s", module.website_s3_bucket.name, module.website_s3_bucket.domain)
}