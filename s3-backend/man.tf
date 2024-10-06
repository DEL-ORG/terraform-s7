provider "aws" {
  region = "us-east-1"  # Replace with your preferred region
}

# S3 bucket to store the Terraform state file
resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "terraform-s7-state-test"  # Replace with your unique bucket name
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "Terraform State Bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.tf_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}