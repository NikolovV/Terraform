resource "aws_iam_user" "sample_user" {
  name = var.iam_user_name
}

resource "aws_iam_group" "user_group" {
  name = var.iam_group_name
}

resource "aws_iam_group_membership" "user_assigment" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.sample_user.name
  ]

  group = aws_iam_group.user_group.name
}

resource "aws_iam_policy" "policy" {
  name = "test_policy"
  path = "/"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "policy_attach" {
  name   = "policy-attachment"
  groups = [aws_iam_group.user_group.name]
  #policy_arn = var.iam_policy_arn
  policy_arn = aws_iam_policy.policy.arn
}