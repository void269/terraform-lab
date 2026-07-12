variable "http_port" {
  description = "SG Inbound port number"
  type = number
  default = 80
}

variable "aws_region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}
/*
variable "aws_az" {
  description = "AWS Availability Zone"
  type = string
  default = "us-east-1a"
}
*/
variable "env" {
  description = "Environment"
  type = string
  default = "lab"
}

variable "ami_image_id" {
  description = "AMI ID for AWS Linux EC2 Instance"
  type = string
  default = "ami-01edba92f9036f76e"
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t2.micro"
}

variable "access_key" {
  description = "IAM access key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "IAM secret key"
  type        = string
  sensitive   = true
}

// VPC Vars

variable "cidr_block" {
  description = "VPC CIDR Block"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks"
  type = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}

variable "aws-az-list" {
  description = "List of Availability Zones"
  type = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
/*
variable "vpc_name" {
  description = "VPC Name"
  type = string
  default = "vpc01"
}
*/