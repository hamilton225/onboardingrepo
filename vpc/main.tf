#provider
provider "aws" {
  region = "${var.aws_region}"
}

#vpc
resource "aws_vpc" "ob-vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "ob-test-vpc"
  }
}
