# terraform-aws-nginx-server

## 📦 Project Overview

This is a complete Infrastructure as Code (IaC) project that deploys a production-ready Nginx web server on AWS using Terraform. The infrastructure includes a custom VPC with public and private subnets, security groups, and an EC2 instance running Nginx.

## 🗂️ Complete File Structure

```
terraform-aws-nginx-server/
│
├── main.tf                    # Provider configuration and Terraform settings
├── variables.tf               # All variable definitions
├── terraform.tfvars.example   # Example variable values (copy to terraform.tfvars)
│
├── vpc.tf                     # VPC, Subnets, IGW, Route Tables
├── ec2.tf                     # EC2 Instance with Nginx user_data
├── securitygroup.tf           # Security Group rules
├── output.tf                  # Output definitions
│
├── .gitignore                 # Git ignore patterns
├── Makefile                   # Automation commands
│
├── README.md                  # Main documentation
├── DEPLOYMENT_GUIDE.md        # Step-by-step deployment instructions
└── PROJECT_SUMMARY.md         # This file
```

## 📋 File Descriptions

### Core Terraform Files

| File | Purpose | Key Components |
|------|---------|----------------|
| `main.tf` | Provider configuration | AWS provider, Terraform version, backend config |
| `variables.tf` | Variable declarations | Region, environment, CIDR blocks, instance type |
| `terraform.tfvars.example` | Example values | Template for terraform.tfvars |
| `vpc.tf` | Network infrastructure | VPC, subnets, IGW, route tables |
| `ec2.tf` | Compute resources | EC2 instance with Nginx installation |
| `securitygroup.tf` | Security rules | Inbound/outbound traffic rules |
| `output.tf` | Output definitions | Public IP, URLs, resource IDs |

### Documentation Files

| File | Purpose |
|------|---------|
| `README.md` | Main project documentation, quick start guide |
| `DEPLOYMENT_GUIDE.md` | Detailed step-by-step deployment instructions |
| `PROJECT_SUMMARY.md` | Project overview and file reference |

### Utility Files

| File | Purpose |
|------|---------|
| `.gitignore` | Exclude sensitive files from Git |
| `Makefile` | Command shortcuts for common operations |

## 🎯 Key Features

### Infrastructure Components
- ✅ Custom VPC (10.0.0.0/16)
- ✅ Public Subnet (10.0.1.0/24)
- ✅ Private Subnet (10.0.2.0/24)
- ✅ Internet Gateway
- ✅ Route Tables with proper associations
- ✅ Security Group (HTTP access on port 80)
- ✅ EC2 Instance (t2.micro, Ubuntu 22.04)
- ✅ Automated Nginx installation via user_data

### Terraform Features
- ✅ Modular file organization
- ✅ Comprehensive variable system
- ✅ Detailed outputs
- ✅ Default tags on all resources
- ✅ Version pinning for providers
- ✅ Remote backend configuration (optional)

## 🚀 Quick Start Commands

### Using Terraform Directly
```bash
# Initialize
terraform init

# Plan deployment
terraform plan

# Deploy
terraform apply

# Destroy
terraform destroy
```

### Using Makefile (Recommended)
```bash
# Show all available commands
make help

# Initial setup
make setup

# Full deployment
make deploy

# Check Nginx status
make check-nginx

# Cleanup
make destroy
```

## 📊 Resource Count

The project creates **9 AWS resources**:

1. VPC
2. Public Subnet
3. Private Subnet
4. Internet Gateway
5. Route Table
6. Route Table Association
7. Security Group
8. EC2 Instance
9. Elastic IP (implicit with public IP)

## 🔑 Required AWS Permissions

Your AWS user/role needs these permissions:
- `ec2:*` (EC2 full access)
- `vpc:*` (VPC full access)

Or use the AWS managed policy: `AdministratorAccess` for testing.

## 📤 Available Outputs

After deployment, these outputs are available:

| Output | Description |
|--------|-------------|
| `Instance_public_ip` | Public IP of EC2 instance |
| `instance_url` | Direct HTTP URL to Nginx |
| `Instance_type` | EC2 instance type |
| `VPC_ID` | VPC identifier |
| `Public_Subnet_ID` | Public subnet identifier |
| `Private_Subnet_ID` | Private subnet identifier |
| `Security_Group_ID` | Security group identifier |
| `Internet_Gateway_ID` | IGW identifier |
| `Route_Table_ID` | Route table identifier |
| `Route_Table_Association_ID` | Association identifier |
| `Nginx_download_status` | Installation status message |

## 🎨 Customization Options

### Easy Customizations (via terraform.tfvars)
- AWS Region
- Environment name
- VPC and Subnet CIDR blocks
- EC2 instance type
- AMI ID

### Advanced Customizations (edit .tf files)
- Add multiple availability zones
- Add NAT Gateway for private subnet
- Configure HTTPS with SSL/TLS
- Add SSH key pair for instance access
- Add additional security group rules
- Configure CloudWatch monitoring
- Add Auto Scaling Group
- Add Application Load Balancer

## 🔐 Security Considerations

### Current Security Posture
- ✅ Security group restricts to HTTP only
- ✅ No SSH access (no keys configured)
- ⚠️ HTTP traffic allowed from anywhere (0.0.0.0/0)
- ⚠️ No HTTPS configured
- ⚠️ No WAF protection

### Recommended Security Enhancements
1. Add SSH access with IP restrictions
2. Implement HTTPS with ACM certificates
3. Add WAF for web application protection
4. Enable VPC Flow Logs
5. Configure CloudWatch alarms
6. Use AWS Systems Manager for secure access
7. Implement least privilege IAM policies
8. Enable AWS Config for compliance

## 💰 Cost Estimation

### Monthly Costs (AWS Free Tier)
- **VPC Components**: $0 (Free)
- **EC2 t2.micro**: $0 (750 hrs/month free tier)
- **Data Transfer**: $0 (First 100GB/month free)
- **Elastic IP**: $0 (while attached to running instance)

### Monthly Costs (After Free Tier)
- **EC2 t2.micro**: ~$8.50/month
- **Data Transfer**: $0.09/GB (beyond 100GB)
- **Total**: ~$10-15/month (typical usage)

## 🧪 Testing Checklist

After deployment, verify:
- [ ] VPC created with correct CIDR
- [ ] Subnets created in correct CIDR ranges
- [ ] Internet Gateway attached to VPC
- [ ] Route table has default route to IGW
- [ ] Security group allows port 80
- [ ] EC2 instance has public IP
- [ ] Can access Nginx welcome page via HTTP
- [ ] All outputs displayed correctly

## 📚 Dependencies

### Required Software
- Terraform >= 1.0
- AWS CLI >= 2.0
- Git
- Make (optional, for Makefile usage)

### Terraform Providers
- `hashicorp/aws` ~> 5.0

### AWS Services Used
- Amazon VPC
- Amazon EC2
- Amazon EC2 Security Groups

## 🐛 Common Issues and Solutions

### Issue: "terraform: command not found"
**Solution**: Install Terraform from https://www.terraform.io/downloads

### Issue: "No valid credential sources found"
**Solution**: Configure AWS credentials using `aws configure`

### Issue: Cannot access Nginx server
**Solution**: Wait 2-3 minutes for user_data script to complete

### Issue: VPC Limit Exceeded
**Solution**: Delete unused VPCs or request limit increase

## 🔄 Maintenance Tasks

### Regular Maintenance
- Keep Terraform version updated
- Update AWS provider version quarterly
- Rotate AWS access keys every 90 days
- Review and update AMI IDs for security patches
- Monitor AWS costs

### State File Management
- Backup state files regularly
- Use remote state for team collaboration
- Enable state locking with DynamoDB
- Never manually edit state files

## 🚀 Next Steps and Enhancements

### Phase 1: Basic Improvements
1. Add SSH key pair for instance access
2. Configure CloudWatch basic monitoring
3. Add Route53 for custom domain
4. Implement HTTPS with Let's Encrypt

### Phase 2: High Availability
1. Add Auto Scaling Group
2. Add Application Load Balancer
3. Deploy across multiple AZs
4. Add RDS database in private subnet

### Phase 3: Advanced Features
1. Implement blue-green deployments
2. Add WAF and Shield protection
3. Configure S3 for static assets
4. Add CloudFront CDN
5. Implement CI/CD pipeline
6. Add comprehensive monitoring and logging

## 📞 Support and Resources

### Documentation
- [Main README](README.md) - Project overview
- [Deployment Guide](DEPLOYMENT_GUIDE.md) - Step-by-step instructions
- This file - Complete project reference

### External Resources
- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

### Getting Help
1. Check the troubleshooting sections in documentation
2. Review Terraform plan output carefully
3. Enable Terraform debug logs: `export TF_LOG=DEBUG`
4. Check AWS Console for resource status
5. Review CloudWatch logs if available

## 🤝 Contributing

To contribute to this project:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is open source and available under the MIT License.

## ✅ Project Checklist

Use this checklist for deployment:
- [ ] Clone repository
- [ ] Install prerequisites (Terraform, AWS CLI)
- [ ] Configure AWS credentials
- [ ] Copy and edit terraform.tfvars
- [ ] Run `terraform init`
- [ ] Run `terraform plan` and review
- [ ] Run `terraform apply`
- [ ] Verify all outputs
- [ ] Test Nginx access via HTTP
- [ ] Document any customizations
- [ ] Configure backup strategy
- [ ] Set up monitoring (if production)

---

**Project Status**: Production Ready ✅
**Last Updated**: 2025
**Terraform Version**: >= 1.0
**AWS Provider Version**: ~> 5.0
