provider "aws" {
  region = "us-east-1"
}

#creation of VPC
resource "aws_vpc" "mod" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    Name = "${var.name}"
  }
}

#public subnets
resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.public_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"
  count             = "${length(var.public_subnets)}"

  tags {
    Name = "${var.name}-subnet-public-${element(var.azs, count.index)}"
  }

  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

#private subnets
resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"
  count             = "${length(var.private_subnets)}"

  tags {
    Name = "${var.name}-subnet-private-${element(var.azs, count.index)}"
  }
}

#internet gateway for public subnet
resource "aws_internet_gateway" "mod" {
  vpc_id = "${aws_vpc.mod.id}"

  tags {
    Name = "${var.name}-igw"
  }
}



#elastic ip creation for NAT for Private subnets
resource "aws_eip" "nateip" {
  vpc   = true
}

#creation of NAT Gateway in Public sunet
resource "aws_nat_gateway" "natgw" {
  allocation_id = "${aws_eip.nateip.id}"
  subnet_id     = "${element(aws_subnet.public.*.id, 1)}"
}

#route table for public subnet
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.mod.id}"
  tags {
    Name = "${var.name}-rt-public"
  }
}

#creation of private route table
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.mod.id}"
  tags {
    Name = "${var.name}-rt-private"
  }
}

#public subnet assciation to public route
resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

#associate private subnets to route table
resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}

#routing private subnets via route
resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.natgw.id}"
}

#adding route table entry in public route for public subnets
resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.mod.id}"
}







