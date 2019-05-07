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
  vpc_id            = "${aws_vpc.ob-vpc.id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "eu-west-1a"

  tags {
    Name = "OB-VPC Public Subnet"
  }
}

#private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id            = "${aws_vpc.ob-vpc.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "eu-west-1b"

  tags {
    Name = "OB-VPC Private Subnet"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.ob-vpc.id}"

  tags {
    Name = "VPC IGW"
  }
}

# Define the route table
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.ob-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Public Subnet RT"
  }
}

#assign route table to the public Subnet
resource "aws_route_table_association" "ob-public-rt" {
  subnet_id = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}



