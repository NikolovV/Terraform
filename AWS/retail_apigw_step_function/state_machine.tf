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
          "Next" : "AvailabilityCheck"
        },
        "AvailabilityCheck" : {
          "Type" : "Choice",
          "Choices" : [
            {
              "And" : [
                {
                  "Variable" : "$.[0].availability",
                  "BooleanEquals" : true
                },
                {
                  "Variable" : "$.[1].availability",
                  "BooleanEquals" : true
                }
              ],
              "Next" : "SucceedState"
            }
          ],
          "Default" : "FailState"
        },
        "FailState" : {
          "Type" : "Fail",
          "Error" : "Tracnsaction can't be compleate.",
          "Cause" : "Account or stock availability fail."
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
    }
  }

  type = var.state_machine_config["type"]

  attach_cloudwatch_logs_policy = var.state_machine_config["attach_cloudwatch_logs_policy"]
  tags                          = var.resource_tags
}