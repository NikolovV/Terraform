resource "aws_s3_bucket" "ec2_bucket" {
  bucket = "ec2-bucket-0101"
  acl    = "private"
  force_destroy = true

  tags = var.res_tags
}
