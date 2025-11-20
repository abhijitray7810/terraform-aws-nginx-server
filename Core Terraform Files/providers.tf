# AWS Provider configuration
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "nginx-vpc-project"
      Environment = var.environment
      Terraform   = "true"
    }
  }
}
