variable "aws_region" {
  description = "Region for the VPC"
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "172.23.0.0/16"
}
