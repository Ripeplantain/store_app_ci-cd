#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <table-name>"
    exit 1
fi

BUCKET_NAME="african-terraform-backend"
REGION=$1

#check if bucket exists
if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
    echo "Bucket '$BUCKET_NAME' already exists."
else
    echo "Bucket '$BUCKET_NAME' does not exist. Creating bucket..."

    aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION" --endpoint-url https://s3.amazonaws.com   
    aws s3api put-bucket-versioning --bucket "$BUCKET_NAME" --versioning-configuration Status=Enabled
    aws s3api put-object --bucket $BUCKET_NAME --key terraform

    if [ $? -eq 0 ]; then
        echo "Bucket '$BUCKET_NAME' created successfully."
    else
        echo "Failed to create bucket '$BUCKET_NAME'."
    fi
fi