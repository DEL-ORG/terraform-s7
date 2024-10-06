# Terraform backend configuration
terraform {
  backend "s3" {
    bucket         = "terraform-s7-state-test"
    key            = "ec2/terraform.tfstate"
    region         = "us-east-1"  # Ensure region is correct
    # dynamodb_table = aws_dynamodb_table.tf_state_lock.name
    encrypt        = true
  }
}