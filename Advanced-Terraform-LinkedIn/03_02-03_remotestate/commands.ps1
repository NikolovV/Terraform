# Initialize
terraform init `
    -backend-config="bucket=red30-tfstate-20220105" `
    -backend-config="key=red30/ecommerceapp/app.state" `
    -backend-config="region=us-west-1" `
    -backend-config="dynamodb_table=ddb-tf-statelock"

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out vpc_backend.plan -var-file vpc_backend.tfvars
terraform plan -out vpc_backend.tfplan

# start terraform script 
terraform apply -auto-approve vpc_backend.tfplan

# destroy provisioned resource
# terraform plan -destroy -out vpc_backend.plan -var-file vpc_backend.tfvars
terraform plan -destroy -out vpc_backend.tfplan