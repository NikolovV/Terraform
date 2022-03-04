resource "aws_s3_bucket" "s3_beckend" {
  bucket        = var.bucket_name
  force_destroy = true
  acl           = "private"

  versioning {
    enabled = true
  }

  # Grant read/write access to the terraform user
  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${data.aws_iam_user.terraform.arn}"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::${var.bucket_name}/*"
        }
    ]
}
EOF
}

resource "aws_s3_bucket_public_access_block" "s3_beckend" {
  bucket = aws_s3_bucket.s3_beckend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "ddb_statelock" {
  name           = "ddb-tf-statelock"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"
  table_class    = "STANDARD"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_iam_user_policy" "terraform_user_dbtable" {
  name   = "tf-iam-backend"
  user   = data.aws_iam_user.terraform.user_name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["dynamodb:*"],
            "Resource": [
                "${aws_dynamodb_table.ddb_statelock.arn}"
            ]
        }
   ]
}
EOF
}

