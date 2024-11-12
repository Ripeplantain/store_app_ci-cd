variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
}

variable "aws_region" {
  description = "AWS region"
  type = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type = string
}