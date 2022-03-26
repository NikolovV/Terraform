resource "aws_sns_topic" "sns_retail_topic" {
  name = var.sns_name
  tags = var.resource_tags
}

resource "aws_sns_topic_subscription" "reail_email_subscr" {
  topic_arn = aws_sns_topic.sns_retail_topic.arn
  protocol  = var.sns_subscr_config.protocol
  endpoint  = var.sns_subscr_config.email_endpoint
}