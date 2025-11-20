# Terraform Nginx VPC Project

This Terraform project deploys a complete infrastructure on AWS including:
- VPC with public and private subnets
- Internet Gateway and Route Table
- EC2 instance running Nginx web server
- Security groups for network security

## Architecture
Internet → Internet Gateway → Route Table → Public Subnet → EC2 Instance (Nginx)
|
Private Subnet

text

## Prerequisites

- Terraform v1.0 or higher
- AWS account with appropriate permissions
- AWS CLI configured with credentials

## Resources Created

- 1 VPC (10.0.0.0/16)
- 1 Public Subnet (10.0.1.0/24)
- 1 Private Subnet (10.0.2.0/24)
- 1 Internet Gateway
- 1 Route Table
- 1 EC2 Instance (t2.micro) with Nginx
- 1 Security Group

## Usage

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/terraform-nginx-vpc.git
   cd terraform-nginx-vpc
Initialize Terraform

bash
terraform init
Plan the deployment

bash
terraform plan
Apply the configuration

bash
terraform apply
Access the Nginx server
After deployment, Terraform will output the instance URL. Open it in your browser:

text
http://<public-ip>
Destroy resources (when done)

bash
terraform destroy
Variables
You can customize the deployment by modifying the variables.tf file or using Terraform variables:

Variable	Description	Default
aws_region	AWS region	us-east-1
vpc_cidr	VPC CIDR block	10.0.0.0/16
public_subnet_cidr	Public subnet CIDR	10.0.1.0/24
private_subnet_cidr	Private subnet CIDR	10.0.2.0/24
instance_type	EC2 instance type	t2.micro
Example of using custom variables:

```bash
terraform apply -var="aws_region=us-west-2" -var="instance_type=t3.micro"
Outputs
After successful deployment, Terraform will output:

Instance public IP

Instance URL

VPC and subnet IDs

Security group ID

And other resource identifiers

Security Notes
The security group allows HTTP (80) and SSH (22) from anywhere

Consider restricting SSH access to your IP in production

EC2 instance is launched in public subnet with public IP

Dependencies
AWS Provider (~> 5.0)

VPC must be created before subnets

Internet Gateway must be created before route table

Security group must be created before EC2 instance

Troubleshooting
Instance not accessible: Check security group rules and route table

Terraform plan fails: Verify AWS credentials and region

Nginx not running: Check instance user data script in EC2 console

Cleanup
Always remember to destroy resources when not in use to avoid unnecessary charges:

bash
terraform destroy
text

## GitHub Repository Name

**Suggested Repository Name**: `terraform-nginx-vpc`

## Dependencies Summary

The main dependencies in this project are:

1. **Terraform AWS Provider** (~> 5.0)
2. **Resource Dependencies**:
   - VPC → Subnets
   - VPC → Internet Gateway
   - Internet Gateway → Route Table
   - Route Table + Subnet → Route Table Association
   - VPC + Security Group → EC2 Instance
   - Security Group → EC2 Instance

## Deployment Steps

1. Create the GitHub repository with the name `terraform-nginx-vpc`
2. Add all the files in the structure shown above
3. Configure AWS credentials on your local machine
4. Run `terraform init` to initialize the project
5. Run `terraform plan` to see what will be created
6. Run `terraform apply` to deploy the infrastructure

This complete setup provides a robust, well-documented Terraform project that deploys a functional Nginx web server in a properly configured VPC environment.
