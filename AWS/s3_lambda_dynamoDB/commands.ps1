# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out s3_lam_ddb.plan -var-file s3_lam_ddb.tfvars
terraform plan -out s3_lam_ddb.tfplan

# start terraform script 
terraform apply -auto-approve s3_lam_ddb.tfplan

# destroy provisioned resource
# terraform plan -destroy -out s3_lam_ddb.plan -var-file s3_lam_ddb.tfvars
terraform plan -destroy -out s3_lam_ddb.tfplan

