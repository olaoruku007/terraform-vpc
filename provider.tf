provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      Name        = "${var.Environment}-terraform-pro-vpc"
      Environment = var.Environment
      ManagedBy   = "Terraform"
    }
  }

}





