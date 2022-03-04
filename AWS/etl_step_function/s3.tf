resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_config["bucket"]

  # Comment this in case of Providers/hashicorp/aws version 4.0.0
  acl = var.bucket_config["acl"]

  force_destroy = var.bucket_config["force_destroy"]

  tags = var.resource_tags
}

# Changes according  Providers/hashicorp/aws version 4.0.0
# resource "aws_s3_bucket_acl" "bucket_acl" {
#   bucket = aws_s3_bucket.bucket.id
#   acl    = var.bucket_config["acl"]
# }

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = module.lambda_s3_stfn.lambda_function_arn
    events              = var.s3_notofication_events
    filter_prefix       = var.s3_notofication_filter_prefix
  }

  # To avoid "Circular dependency between resources" at 
  # "Error: error putting S3 Bucket Notification Configuration: InvalidArgument: Unable to validate the following destination configurations"
  depends_on = [
    module.lambda_s3_stfn.lambda_role_arn
  ]
}
