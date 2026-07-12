output "public_ip" {
  value       = aws_instance.apache-webserver[0].public_ip
  description = "EC2 public IP to view deployed Web Server"
}

output "security_group" {
  value       = aws_security_group.allow-http.id
  description = "EC2 instances Security Group ID"
}