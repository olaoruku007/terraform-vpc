provider "aws" {
  region = "us-west-1"
  assume_role {
    role_arn     = "arn:aws:iam::812818276534:role/AWSAdmin"
    session_name = "TerraformSession"
  }

}


