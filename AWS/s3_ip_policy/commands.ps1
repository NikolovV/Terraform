# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out s3_ip_policy.plan -var-file s3_ip_policy.tfvars
terraform plan -out s3_ip_policy.tfplan

# Load data into bucket
aws s3 sync data/ s3://$(terraform output -raw s3_bucket_name)/
aws s3 ls s3://$(terraform output -raw s3_bucket_name)

# start terraform script 
terraform apply -auto-approve s3_ip_policy.tfplan

# destroy provisioned resource
# terraform plan -destroy -out s3_ip_policy.plan -var-file s3_ip_policy.tfvars
terraform plan -destroy -out s3_ip_policy.tfplan