variable "server_port" {
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