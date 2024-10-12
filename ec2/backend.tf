# Terraform backend configuration
terraform {
  backend "s3" {
    bucket         = "terraform-s7-state-test"
    key            = "ec2/terraform.tfstate"
    region         = "us-east-1"  # Ensure region is correct
    dynamodb_table = "terraform-s7-state-locks"
    encrypt        = true
  }
}