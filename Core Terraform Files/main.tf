# Main Terraform configuration
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # S3 backend configuration - update with your bucket details
    # bucket = "your-terraform-state-bucket"
    # key    = "terraform-nginx-vpc/terraform.tfstate"
    # region = "us-east-1"
  }
}
