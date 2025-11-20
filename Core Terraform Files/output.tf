output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.mynginxserver.public_ip
}

output "instance_type" {
  description = "The type of the EC2 instance"
  value       = aws_instance.mynginxserver.instance_type
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.my_security_group_tf.id
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc_tf.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.my_public_subnet_tf.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.my_private_subnet_tf.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.my_igw_tf.id
}

output "route_table_id" {
  description = "The ID of the Route Table"
  value       = aws_route_table.my_route_table_tf.id
}

output "instance_url" {
  description = "The URL to access the Nginx server"
  value       = "http://${aws_instance.mynginxserver.public_ip}"
}

output "nginx_status" {
  description = "The status of Nginx service on the EC2 instance"
  value       = "Nginx should be installed and running on the instance"
}
