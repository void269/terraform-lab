#!/bin/bash -xe
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<html><body><h1>Welcome to AWS - Provisioned by Terraform via EC2 UserData</h1>" > /var/www/html/index.html
echo "</body></html>" >> /var/www/html/index.html