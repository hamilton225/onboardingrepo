variable "aws_region" {
  description = "Region for the VPC"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
}
