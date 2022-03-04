data "archive_file" "filie-zip" {
  type        = "zip"
  source_file = "${var.lambda_file_name}.py"
  output_path = "${var.lambda_file_name}.zip"
}

# data "aws_iam_policy_document" "iam-policy-document" {
#   statement {
#     sid       = "some_id"
#     actions   = [
#       "sqs:ReceiveMessage",
#       "sqs:DeleteMessage",
#       "sqs:GetQueueAttributes"
#     ]
#     resources = [
#       aws_sqs_queue.terraform_main-queue.arn
#     ]
#   }
# }

resource "aws_iam_policy" "iam-policy" {
  name   = "iam-policy"
  policy = jsonencode(//data.aws_iam_policy_document.iam-policy-document.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
      ],
      "Effect": "Allow",
      "Resource": "${aws_sqs_queue.terraform_main-queue.arn}"
    }
  ]
})

}

resource "aws_iam_role_policy_attachment" "iam-role-policy-att" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.iam-policy.arn
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = jsonencode(
{
  "Version" : "2012-10-17",
  "Statement" : [
    {
      "Action" : "sts:AssumeRole",
      "Principal" : {
        "Service" : "lambda.amazonaws.com"
      },
      "Effect" : "Allow",
      "Sid" : ""
    }
  ]
})

  tags = {
    Name        = "${terraform.workspace}_lambda-iam-role"
    Provisioner = var.tags-descr["Provisioner"]
    Project     = var.tags-descr["Project"]
  }
}

resource "aws_lambda_function" "lambda" {
  filename      = "${var.lambda_file_name}.zip"
  function_name = "${terraform.workspace}_terraform_lambda"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "${var.lambda_file_name}.${var.lambda_handler}"

  source_code_hash = "data.archive_file.filie-zip.filebase64sha256"

  runtime = var.lambda_runtime

  tags = {
    Name        = "${terraform.workspace}_lambda"
    Provisioner = var.tags-descr["Provisioner"]
    Project     = var.tags-descr["Project"]
  }
}

resource "aws_sqs_queue" "terraform_main-queue" {
  name             = "terraform-main-queue"
  delay_seconds    = 30
  max_message_size = 2048

  tags = {
    Name        = "${terraform.workspace}_main-queue"
    Provisioner = var.tags-descr["Provisioner"]
    Project     = var.tags-descr["Project"]
  }
}

resource "aws_sqs_queue" "terraform_queue" {
  name             = "terraform-queue"
  delay_seconds    = 30
  max_message_size = 2048

  tags = {
    Name        = "${terraform.workspace}_queue"
    Provisioner = var.tags-descr["Provisioner"]
    Project     = var.tags-descr["Project"]
  }
}

resource "aws_lambda_event_source_mapping" "lambda-trigger" {
  event_source_arn = aws_sqs_queue.terraform_main-queue.arn
  function_name    = aws_lambda_function.lambda.arn
}