# Trigger State machine
curl -X POST -H "Content-Type: application/json" -d @test/order_available_cust.json $(terraform output -raw api_gw_endpoint)
curl -X POST -H "Content-Type: application/json" -d @test/order_missing_cust.json $(terraform output -raw api_gw_endpoint)

# Load test data
aws dynamodb batch-write-item --request-items file://test/bank_data.json
aws dynamodb batch-write-item --request-items file://test/shop_data.json
# Local
aws dynamodb batch-write-item --request-items file://test/bank_data.json --endpoint-url http://localhost:8000
aws dynamodb batch-write-item --request-items file://test/shop_data.json --endpoint-url http://localhost:8000

# Check is it loaded.
aws dynamodb scan --table-name bank-service
aws dynamodb scan --table-name shop-service
# Local
aws dynamodb scan --table-name bank-service --endpoint-url http://localhost:8000
aws dynamodb scan --table-name shop-service --endpoint-url http://localhost:8000
