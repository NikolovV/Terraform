# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create workspace
terraform workspace new DEV
terraform workspace new QA
terraform workspace new STAGE
terraform workspace new PROD

# list workspace
terraform workspace list

# change workspace
terraform workspace select DEV

# create terraform plan
# terraform plan -out apigw_lambda.plan -var-file apigw_lambda.tfvars
terraform plan -out apigw_lambda.tfplan

# start terraform script 
terraform apply -auto-approve apigw_lambda.tfplan

# destroy provisioned resource
# terraform plan -destroy -out apigw_lambda.plan -var-file apigw_lambda.tfvars
terraform plan -destroy -out apigw_lambda.tfplan

# Invoke lambda using the AWS CLI.
aws lambda invoke --region=us-west-1 --function-name=$(terraform output -raw function_name) --payload '{\"name\":\"John\"}' --cli-binary-format raw-in-base64-out response.json
cat response.json

# Test API GW
curl "$(terraform output -raw base_url)/name?name=John"