###################
### Test API GW ###
###################
# Describe table
aws dynamodb list-tables
aws dynamodb describe-table --table-name "$(terraform output -raw table_name)"
# Local dynamodb
aws dynamodb describe-table --table-name customer_info --endpoint-url http://localhost:8000
aws dynamodb list-tables --endpoint-url http://localhost:8000
aws dynamodb describe-table --table-name customer_info --endpoint-url http://localhost:8000

### Get customer
# curl -s "$(terraform output -raw apigw_endpoind)/customer/we3w3rwr3"
curl "$(terraform output -raw apigw_endpoind)/customer/kj1h2j12h3jk1hxx" 
Invoke-WebRequest -Method Get "$(terraform output -raw apigw_endpoind)/customer/kj1h2j12h3jk1hxx"
aws dynamodb get-item `
    --table-name "$(terraform output -raw table_name)" `
    --key file://Test/aws_cli/get_customer.json `
    --return-consumed-capacity TOTAL `
    --projection-expression "personal_info"
# Local dynamodb 
aws dynamodb scan `
    --table-name customer_info `
    --return-consumed-capacity TOTAL `
    --projection-expression "customer_id, personal_info" `
    --endpoint-url http://localhost:8000

aws dynamodb get-item `
    --table-name customer_info `
    --key file://Test/aws_cli/get_customer_aws_cli.json `
    --return-consumed-capacity TOTAL `
    --endpoint-url http://localhost:8000
    #--projection-expression "customer_id, personal_info.firs_name" `

### Post customer
curl -X "POST" -H "Content-Type: application/json" -d @Test/api_gw/post_customer_api.json "$(terraform output -raw apigw_endpoind)/customer"
aws dynamodb put-item `
    --table-name "$(terraform output -raw table_name)" `
    --item file://Test/aws_cli/post_customer_api.json `
    --return-values ALL_OLD `
    --return-consumed-capacity TOTAL
# Local dynamodb
aws dynamodb put-item `
    --table-name customer_info `
    --item file://Test/aws_cli/post_customer_aws_cli.json `
    --return-values NONE `
    --return-consumed-capacity TOTAL `
    --return-item-collection-metrics SIZE `
    --endpoint-url http://localhost:8000

aws dynamodb batch-write-item `
    --request-items file://Test/aws_cli/psot_customer_batch_aws_cli.json `
    --return-item-collection-metrics SIZE `
    --endpoint-url http://localhost:8000

### Update item
curl -X "PUT" -H "Content-Type: application/json" -d @Test/api_gw/update_item_api.json "$(terraform output -raw apigw_endpoind)/customer"
aws dynamodb update-item `
    --table-name customer_info `
    --key file://Test/aws_cli/update_item_aws_cli_key.json `
    --update-expression "SET #PI.#FN = :fn" `
    --expression-attribute-names file://Test/aws_cli/update_item_aws_cli_names.json `
    --expression-attribute-values file://Test/aws_cli/update_item_aws_cli_values.json  `
    --return-values ALL_NEW `
    --return-consumed-capacity TOTAL `
    --return-item-collection-metrics SIZE `
# Local dynamodb
aws dynamodb update-item `
    --table-name customer_info `
    --key file://Test/aws_cli/update_item_aws_cli_key.json `
    --update-expression "SET #PI.#FN = :fn" `
    --expression-attribute-names file://Test/aws_cli/update_item_aws_cli_names.json `
    --expression-attribute-values file://Test/aws_cli/update_item_aws_cli_values.json  `
    --return-values ALL_NEW `
    --return-consumed-capacity TOTAL `
    --return-item-collection-metrics SIZE `
    --endpoint-url http://localhost:8000
# Removing atribute
aws dynamodb update-item `
    --table-name customer_info `
    --key file://Test/aws_cli/update_item_aws_cli_key.json `
    --update-expression "REMOVE personal_info.first_name" `
    --return-values ALL_NEW `
    --return-consumed-capacity TOTAL `
    --return-item-collection-metrics SIZE `
    --endpoint-url http://localhost:8000

### Delete item
curl -X "DELETE" -H "Content-Type: application/json" -d @Test/api_gw/delete_item_api.json "$(terraform output -raw apigw_endpoind)/customer"
aws dynamodb delete-item `
    --table-name "$(terraform output -raw table_name)" `
    --key file://Test/aws_cli/delete_item_api.json `
    --return-values ALL_OLD `
    --return-consumed-capacity TOTAL `
    --return-item-collection-metrics SIZE
# Local dynamodb
aws dynamodb delete-item `
    --table-name customer_info `
    --key file://Test/aws_cli/delete_item_aws_cli.json `
    --return-values ALL_OLD `
    --return-consumed-capacity TOTAL `
    --return-item-collection-metrics SIZE `
    --endpoint-url http://localhost:8000
