# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# Shifting traffic to green environment
terraform plan -out blue_green.tfplan -var 'traffic_distribution=blue-90'

# Increase traffic to green environment
terraform plan -out blue_green.tfplan -var 'traffic_distribution=split'

# Promote green environment
terraform plan -out blue_green.tfplan -var 'traffic_distrteibution=green'

# Scale down blue environment
terraform plan -out blue_green.tfplan -var 'traffic_distribution=green' -var 'enable_blue_env=false'

# create terraform plan
# terraform plan -out blue_green.plan -var-file blue_green.tfvars
terraform plan -out blue_green.tfplan

# start terraform script 
terraform apply -auto-approve blue_green.tfplan

# destroy provisioned resource
# terraform plan -destroy -out blue_green.plan -var-file blue_green.tfvars
terraform plan -destroy -out blue_green.tfplan