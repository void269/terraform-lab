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

variable "aws_az" {
  description = "AWS Availability Zone"
  type = string
  default = "us-east-1a"
}

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