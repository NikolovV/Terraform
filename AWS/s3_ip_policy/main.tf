data "http" "local_ip" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  local_ip = chomp(data.http.local_ip.body)
}

resource "aws_s3_bucket" "data" {
  bucket_prefix = var.bucket_prefix
  force_destroy = true
  acl           = "private"
}

data "aws_s3_bucket_objects" "data_bucket" {
  bucket = aws_s3_bucket.data.bucket
}

resource "aws_s3_bucket_policy" "private" {
  bucket = aws_s3_bucket.data.id

  policy = jsonencode({
    "Id" = "S3DataBucketPolicy"
    "Statement" = [
      {
        "Action" = "s3:*"
        "Condition" = {
          "NotIpAddress" = {
            "aws:SourceIp" = local.local_ip
          }
        }
        "Effect"    = "Deny"
        "Principal" = "*"
        "Resource" = [
          aws_s3_bucket.data.arn,
          "${aws_s3_bucket.data.arn}/*",
        ]
        "Sid" = "IPAllow"
      },
    ]
    "Version" = "2012-10-17"
  })
}
