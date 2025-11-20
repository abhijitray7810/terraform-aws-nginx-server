# Create EC2 Instance 
resource "aws_instance" "mynginxserver" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.my_public_subnet_tf.id
  vpc_security_group_ids = [aws_security_group.my_security_group_tf.id]

  # This is now handled by the subnet's map_public_ip_on_launch
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    sudo systemctl enable nginx
    sudo systemctl start nginx
    
    # Create a simple HTML page
    sudo cat > /var/www/html/index.html << 'EOL'
    <!DOCTYPE html>
    <html>
    <head>
        <title>Welcome to Nginx</title>
    </head>
    <body>
        <h1>Hello from Terraform!</h1>
        <p>This Nginx server was deployed using Terraform</p>
        <p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
        <p>Availability Zone: $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
    </body>
    </html>
    EOL
    
    EOF

  tags = {
    Name = "Nginx_Server"
  }

  depends_on = [
    aws_internet_gateway.my_igw_tf
  ]
}
