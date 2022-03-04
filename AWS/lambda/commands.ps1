# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create workspace
terraform workspace new dev 
terraform workspace new prod

# list workspace
terraform workspace list

# change workspace
terraform workspace select dev

# list outputs
terraform output -json

# create terraform plan
terraform plan -out lambda_sqs_plan.tfplan -var-file lambda_vars.tfvars

# start terraform script 
terraform apply -auto-approve lambda_sqs_plan.tfplan

# destroy provisioned resource
terraform destroy -auto-approve -var-file lambda_vars.tfvars