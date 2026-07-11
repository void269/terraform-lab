resource "aws_instance" "terraform-ec2" {
  ami               = var.ami_image_id
  count             = 1
  availability_zone = var.aws_az
  instance_type     = var.ec2_instance_type
  vpc_security_group_ids = [ aws_security_group.allow-http.id ]
  
  user_data = <<-EOF
              #!/bin/bash -xe
              yum update -y
              yum install httpd -y
              systemctl start httpd
              systemctl enable httpd
              echo "<html><body><h1>Welcome to AWS - Provisioned by Terraform via EC2 UserData</h1>" > /var/www/html/index.html
              echo "</body></html>" >> /var/www/html/index.html
              EOF
  
  user_data_replace_on_change = true

  tags = {
    env = var.env
  }
}

resource "aws_security_group" "allow-http" {
  name = "app-web-sg-allow-http"

  ingress  {
    from_port = var.http_port
    to_port = var.http_port
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    env = var.env
  }

}

output "public_ip" {
  value = aws_instance.terraform-ec2[0].public_ip
  description = "EC2 public IP to view deployed Web Server"
}