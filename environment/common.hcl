remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "african-terraform-backend"
    key            = "terraform/dev/us-east-1/store-guard.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket         = "african-terraform-backend"
    key            = "terraform/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}
EOF
}