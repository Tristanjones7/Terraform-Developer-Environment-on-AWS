output "vpc_id" {
  description = "ID of the development VPC."
  value       = aws_vpc.dev.id
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = aws_subnet.public.id
}

output "instance_id" {
  description = "ID of the development EC2 instance."
  value       = aws_instance.dev.id
}

output "public_ip" {
  description = "Public IP address of the development EC2 instance."
  value       = aws_instance.dev.public_ip
}

output "ssh_command" {
  description = "Example SSH command for the Ubuntu instance."
  value       = "ssh ubuntu@${aws_instance.dev.public_ip}"
}
