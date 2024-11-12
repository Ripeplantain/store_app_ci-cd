#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <table-name>"
    exit 1
fi

TABLE_NAME="terraform-lock-table"
REGION=$1

TABLE_EXISTS=$(aws dynamodb list-tables --query "TableNames" --output text | grep -w "$TABLE_NAME")

if [ -n "$TABLE_EXISTS" ]; then
    echo "Table '$TABLE_NAME' exists in DynamoDB."
else
    aws dynamodb create-table \
    --table-name "$TABLE_NAME" \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5  
fi