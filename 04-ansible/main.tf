//Building the VPC
resource "aws_vpc" "vpc01" {
  cidr_block = var.cidr_block

  tags = {
    Name = "AWS VPC for ${var.env}"
    ENV = var.env
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc01.id

  tags = {
    Name = "VPC Internet Gateway"
    ENV = var.env
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id  = aws_vpc.vpc01.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.aws_az_list, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet ${count.index + 1}"
    ENV = var.env
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id  = aws_vpc.vpc01.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone  = element(var.aws_az_list, count.index)
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

resource "aws_route_table_association" "aws-rt" {
  count = length(var.public_subnet_cidrs)
  subnet_id  = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "net-traffic" {
  name = "net-traffic-sg"
  description = "Allow inbound/outbound traffic"
  vpc_id = aws_vpc.vpc01.id

  ingress {
    description = "SSH from anywhere"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-network-traffic"
    ENV = var.env
  }
}

//Build EC2
resource "aws_instance" "ec2" {
  ami = var.ami_image_id
  count = 1
  availability_zone = element(var.aws_az_list, 0)
  instance_type = var.ec2_instance_type
  key_name = var.ssh_key
  vpc_security_group_ids = [aws_security_group.net-traffic.id]

  tags = {
    ENV = var.env
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "Waiting 60s for ec2 instance to be ready to ssh into ..."
      sleep 60
      ANSIBLE_HOST_KEY_CHECKING=False \   # Needed in 
      ansible-playbook \
        -i ${self.public_ip}, \
        --private-key ${var.ssh_key_path} \
        -u ${var.username} \
        ${path.module}/playbook.yml
    EOT
  }

}
