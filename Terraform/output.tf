output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc_name.id
}

output "subnet_id" {
  description = "The ID of the first subnet"
  value       = aws_subnet.subnet_name.id
}

output "devops_server_id" {
  description = "The ID of the first DevOps server"
  value       = aws_instance.server_name.id
}

output "devops_server_private_ip" {
  description = "The private IP of the first DevOps server"
  value       = aws_instance.server_name.private_ip
}

output "devops_server_public_ip" {
  description = "The private IP of the first DevOps server"
  value       = aws_instance.server_name.public_ip
}
