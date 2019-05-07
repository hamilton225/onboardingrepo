variable "aws_region" {
  description = "Region for the VPC"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
}

variable "azs" {
  type = "list"
}

variable "public_subnets_cidr" {
  type = "list"
}

variable "private_subnets_cidr" {
  type = "list"
}
