locals {
  definitions = jsonencode(
    {
      "Comment" : "Example of the Amazon States Language using Parallel states",
      "StartAt" : "ParallelState",
      "States" : {
        "ParallelState" : {
          "Type" : "Parallel",
          "Branches" : [
            {
              "StartAt" : "CheckAccountAvailability",
              "States" : {
                "CheckAccountAvailability" : {
                  "Comment" : "Checks whether account have enough balance.",
                  "Type" : "Task",
                  "Resource" : "arn:aws:states:::lambda:invoke",
                  "Parameters" : {
                    "FunctionName" : "${module.lambda_check_account.lambda_function_name}",
                    "Payload.$" : "$"
                  },
                  "ResultSelector" : {
                    "availability.$" : "$.Payload.availability",
                    "Error.$" : "$.Payload.Error"
                  },
                  "End" : true
                }
              }
            },
            {
              "StartAt" : "CheckStockAvailability",
              "States" : {
                "CheckStockAvailability" : {
                  "Comment" : "Checks whether store have requested items.",
                  "Type" : "Task",
                  "Resource" : "arn:aws:states:::lambda:invoke",
                  "Parameters" : {
                    "FunctionName" : "${module.lambda_check_stock.lambda_function_name}",
                    "Payload.$" : "$"
                  },
                  "ResultSelector" : {
                    "stockAvailability.$" : "$.Payload.stockAvailability",
                    "Error.$" : "$.Payload.Error"
                  },
                  "End" : true
                }
              }
            }
          ],
          "ResultPath" : "$.parallelResult",
          "Next" : "PassStateFlatParrallelArrayOutput",
          "Catch" : [
            {
              "ErrorEquals" : [
                "Exception"
              ],
              "Next" : "SendFailMessageToSNS"
            }
          ]
        },
        "PassStateFlatParrallelArrayOutput" : {
          "Comment" : "Pass state to flatten parallel array output.",
          "Type" : "Pass",
          "Next" : "AvailabilityCheck",
          "Parameters" : {
            "accountAvailability.$" : "$.parallelResult[0].availability",
            "accountError.$" : "$.parallelResult[0].Error",
            "stockAvailability.$" : "$.parallelResult[1].stockAvailability",
            "stockError.$" : "$.parallelResult[1].Error"
          },
          "ResultPath" : "$.parallelResult"
        },
        "AvailabilityCheck" : {
          "Type" : "Choice",
          "Choices" : [
            {
              "And" : [
                {
                  "Variable" : "$.parallelResult.accountAvailability",
                  "BooleanEquals" : true
                },
                {
                  "Variable" : "$.parallelResult.stockAvailability",
                  "BooleanEquals" : true
                }
              ],
              "Next" : "SendAcceptanceMessageToSNS"
            }
          ],
          "Default" : "SendFailMessageToSNS"
        },
        "SendFailMessageToSNS" : {
          "Type" : "Task",
          "Resource" : "arn:aws:states:::sns:publish",
          "Parameters" : {
            "TopicArn" : "${aws_sns_topic.sns_retail_topic.arn}",
            "Message" : {
              "Input" : "${var.sns_fail_message}"
            }
          },
          "Next" : "FailState"
        },
        "FailState" : {
          "Type" : "Fail",
          "Error" : "Transaction can't be complete.",
          "Cause" : "Account or stock availability fail."
        },
        "SendAcceptanceMessageToSNS" : {
          "Type" : "Task",
          "Resource" : "arn:aws:states:::sns:publish",
          "Parameters" : {
            "TopicArn" : "${aws_sns_topic.sns_retail_topic.arn}",
            "Message" : {
              "Input" : "${var.sns_success_message}"
            }
          },
          "Next" : "SucceedState"
        },
        "SucceedState" : {
          "Type" : "Succeed"
        }
      }
  })
}

module "step_function" {
  source = "terraform-aws-modules/step-functions/aws"

  name          = var.state_machine_config["name"]
  definition    = local.definitions
  policy        = var.state_machine_config["policy"]
  attach_policy = var.state_machine_config["attach_policy"]

  service_integrations = {
    lambda = {
      lambda = [module.lambda_check_stock.lambda_function_arn, module.lambda_check_account.lambda_function_arn]
    },
    sns = {
      sns = [aws_sns_topic.sns_retail_topic.arn]
    }
  }

  type = var.state_machine_config["type"]

  attach_cloudwatch_logs_policy = var.state_machine_config["attach_cloudwatch_logs_policy"]
  tags                          = var.resource_tags
}
