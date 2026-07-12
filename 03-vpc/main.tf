resource "aws_vpc" "vpc01" {
  cidr_block = var.cidr_block

  tags = {
    Name = "AWS VPC for ${var.env}"
    ENV  = var.env
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc01.id

  tags = {
    Name = "VPC Internet Gateway"
    ENV  = var.env
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.vpc01.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.aws-az-list, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet ${count.index + 1}"
    ENV = var.env
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.vpc01.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.aws-az-list, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet ${count.index + 1}"
    ENV = var.env
  }

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
    ENV = var.env
  }
}

resource "aws_route_table_association" "this" {
  count = length(var.public_subnet_cidrs)
  subnet_id = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}