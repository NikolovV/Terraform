locals {
  definitions = <<EOF
{
  "Comment": "ETL workflow start by S3 create object.",
  "StartAt": "InvokeLoadLambdaFunction",
  "States": {
    "InvokeLoadLambdaFunction": {
      "Type": "Task",
      "Resource": "arn:aws:states:::lambda:invoke",
      "Parameters": {
        "FunctionName": "${module.lambda_load_dynamodb.lambda_function_name}",
        "Payload.$": "$"
      },
      "ResultSelector": {
        "loadResult.$": "$.Payload.loadResult",
        "Error.$": "$.Payload.Error"
      },
      "ResultPath": "$.s3.loadLambdaStatus",
      "OutputPath": "$.s3",
      "Next": "CheckResult"
    },

    "CheckResult": {
      "Type": "Choice",
      "Choices": [
        {
          "Variable": "$.loadLambdaStatus.loadResult",
          "BooleanEquals": true,
          "Next": "MoveToS3Archive"
        }
      ],
      "Default": "FailState"
    },

    "FailState": {
      "Type": "Fail",
      "Error": "ErrorCode",
      "Cause": "Load not pass."
    },

    "MoveToS3Archive": {
      "Type": "Task",
      "Resource": "arn:aws:states:::lambda:invoke",
      "Parameters": {
        "FunctionName": "${module.lambda_archive.lambda_function_name}",
        "Payload": {
          "s3": {
            "bucket.$": "$.bucket",
            "key.$": "$.key"
          }
        }
      },
      "End": true
    }
  }
}
EOF
}

module "step_function" {
  source = "terraform-aws-modules/step-functions/aws"

  name          = var.state_machine_config["name"]
  definition    = local.definitions
  policy        = var.state_machine_config["policy"]
  attach_policy = var.state_machine_config["attach_policy"]

  service_integrations = {
    lambda = {
      lambda = [module.lambda_s3_stfn.lambda_function_arn, module.lambda_archive.lambda_function_arn]
    }
  }

  type = var.state_machine_config["type"]

  attach_cloudwatch_logs_policy = var.state_machine_config["attach_cloudwatch_logs_policy"]
  tags                          = var.resource_tags

  depends_on = [
    module.lambda_load_dynamodb
    # module.lambda_load_dynamodb.lambda_role_arn
  ]
}
