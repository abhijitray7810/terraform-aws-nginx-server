# Deployment Guide

## Step-by-Step Deployment Instructions

### Step 1: Verify Prerequisites

Check Terraform installation:
```bash
terraform version
```

Check AWS CLI configuration:
```bash
aws sts get-caller-identity
```

Expected output should show your AWS account details.

### Step 2: Clone and Prepare

```bash
# Clone the repository
git clone https://github.com/yourusername/terraform-aws-nginx-server.git
cd terraform-aws-nginx-server

# Copy example variables file
cp terraform.tfvars.example terraform.tfvars

# Edit variables if needed
nano terraform.tfvars  # or use your preferred editor
```

### Step 3: Initialize Terraform

```bash
terraform init
```

This command will:
- Download the AWS provider plugin
- Initialize the backend
- Prepare the working directory

### Step 4: Validate Configuration

```bash
terraform validate
```

This checks for syntax errors and validates the configuration.

### Step 5: Format Code (Optional)

```bash
terraform fmt -recursive
```

This ensures consistent formatting across all `.tf` files.

### Step 6: Plan the Deployment

```bash
terraform plan -out=tfplan
```

Review the plan carefully. You should see:
- 9 resources to be created
- VPC, subnets, IGW, route table, security group, and EC2 instance

### Step 7: Apply the Configuration

```bash
terraform apply tfplan
```

Or apply without a saved plan:
```bash
terraform apply
```

Type `yes` when prompted.

### Step 8: Verify Deployment

After successful deployment, Terraform will display outputs:

```
Outputs:

Instance_public_ip = "54.123.45.67"
instance_url = "http://54.123.45.67"
VPC_ID = "vpc-0abc123def456"
...
```

### Step 9: Test the Nginx Server

Wait 2-3 minutes for the user_data script to complete, then:

```bash
# Using curl
curl http://<public_ip>

# Or open in browser
open http://<public_ip>  # macOS
xdg-open http://<public_ip>  # Linux
start http://<public_ip>  # Windows
```

You should see the default Nginx welcome page.

### Step 10: Check Outputs Anytime

```bash
terraform output
terraform output Instance_public_ip
```

## Updating the Infrastructure

To modify the infrastructure:

1. Edit the relevant `.tf` files
2. Run `terraform plan` to preview changes
3. Run `terraform apply` to apply changes

Example: Change instance type
```hcl
# In terraform.tfvars or ec2.tf
instance_type = "t3.small"
```

Then:
```bash
terraform apply
```

## State Management

### View Current State
```bash
terraform show
terraform state list
```

### Refresh State
```bash
terraform refresh
```

### Import Existing Resources (if needed)
```bash
terraform import aws_vpc.my_vpc_tf vpc-xxxxxxxx
```

## Troubleshooting Deployment Issues

### Issue: Permission Denied

**Error**: `Error: creating EC2 Instance: UnauthorizedOperation`

**Solution**: Ensure your AWS IAM user/role has the following permissions:
- EC2 full access
- VPC full access
- Or AdministratorAccess for testing

### Issue: Resource Already Exists

**Error**: `Error: creating VPC: VpcLimitExceeded`

**Solution**: 
1. Check your VPC limit (default is 5 per region)
2. Delete unused VPCs
3. Or request a limit increase through AWS Support

### Issue: Invalid AMI

**Error**: `Error: creating EC2 Instance: InvalidAMIID.NotFound`

**Solution**: Update the AMI ID for your region:
```bash
# Find Ubuntu 22.04 AMI in your region
aws ec2 describe-images \
  --owners 099720109477 \
  --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" \
  --query 'Images | sort_by(@, &CreationDate) | [-1].[ImageId,Name]' \
  --output table
```

### Issue: Cannot Access Web Server

**Checklist**:
1. ✓ Instance has public IP?
2. ✓ Security group allows port 80 from 0.0.0.0/0?
3. ✓ Route table associated with public subnet?
4. ✓ Internet gateway attached to VPC?
5. ✓ Waited 2-3 minutes for user_data to complete?

**Debug Commands**:
```bash
# Check instance status
aws ec2 describe-instances --instance-ids <instance-id>

# SSH into instance (if SSH is enabled)
ssh -i your-key.pem ubuntu@<public-ip>

# Check Nginx status
sudo systemctl status nginx
```

## Cleanup

### Destroy All Resources

```bash
terraform destroy
```

Review the destruction plan and type `yes` to confirm.

### Force Destroy (if normal destroy fails)

```bash
terraform destroy -auto-approve
```

### Remove State Files (after destroy)

```bash
rm -rf .terraform
rm terraform.tfstate*
rm tfplan
```

## Best Practices for Production

1. **Use Remote State**: Configure S3 backend with DynamoDB locking
2. **Use Workspaces**: Separate dev, staging, and prod environments
3. **Version Pin**: Lock provider versions in `main.tf`
4. **Enable Logging**: Add CloudWatch logs and VPC Flow Logs
5. **Backup State**: Regularly backup state files
6. **Use Variables**: Never hardcode sensitive values
7. **Tag Everything**: Implement comprehensive tagging strategy
8. **Module Usage**: Convert to modules for reusability
9. **CI/CD Integration**: Automate with GitHub Actions or GitLab CI
10. **Cost Monitoring**: Enable AWS Cost Explorer and set budgets

## Next Steps

After successful deployment, consider:

1. **Add SSH Access**: Enable SSH for instance management
2. **Setup HTTPS**: Configure SSL/TLS certificates
3. **Add Monitoring**: Implement CloudWatch metrics and alarms
4. **Auto Scaling**: Add Auto Scaling Group for high availability
5. **Load Balancer**: Add ALB for production workloads
6. **Database**: Add RDS instance in private subnet
7. **Backup**: Configure automated backups
8. **Disaster Recovery**: Implement multi-region setup
