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

#public subnets
resource "aws_subnet" "pubsub" {
  count = 2

  vpc_id = "${aws_vpc.ob-vpc.id}"

  cidr_block              = "${element(var.public_subnets_cidr,count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "pubsubnet_${count.index}"
  }
}

#private subnets
resource "aws_subnet" "privsub" {
  count = 2

  vpc_id = "${aws_vpc.ob-vpc.id}"

  cidr_block              = "${element(var.private_subnets_cidr,count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "privsubnet_${count.index}"
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
    Name = "Routes_Table"
  }
}

#assign route table to the public Subnet
resource "aws_route_table_association" "associate_rt" {
  count          = 2
  subnet_id      = "${element(aws_subnet.pubsub.*.id, count.index)}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}
