# Create VPC
resource "aws_vpc" "my_vpc_tf" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "my_vpc_tf"
  }
}

# Create Public Subnet
resource "aws_subnet" "my_public_subnet_tf" {
  cidr_block              = var.public_subnet_cidr
  vpc_id                  = aws_vpc.my_vpc_tf.id
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "my_public_subnet_tf"
  }
}

# Create Private Subnet
resource "aws_subnet" "my_private_subnet_tf" {
  cidr_block        = var.private_subnet_cidr
  vpc_id            = aws_vpc.my_vpc_tf.id
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "my_private_subnet_tf"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "my_igw_tf" {
  vpc_id = aws_vpc.my_vpc_tf.id

  tags = {
    Name = "my_igw_tf"
  }
}

# Create a route Table
resource "aws_route_table" "my_route_table_tf" {
  vpc_id = aws_vpc.my_vpc_tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw_tf.id
  }

  tags = {
    Name = "my_route_table_tf"
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "my_route_table_association_tf" {
  route_table_id = aws_route_table.my_route_table_tf.id
  subnet_id      = aws_subnet.my_public_subnet_tf.id
}
