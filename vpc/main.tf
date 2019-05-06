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
#public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.ob-vpc.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "eu-west-1a"

  tags {
    Name = "OB-VPC Public Subnet"
  }
}

#private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = "${aws_vpc.ob-vpc.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "eu-west-1b"

  tags {
    Name = "OB-VPC Private Subnet"
  }
}