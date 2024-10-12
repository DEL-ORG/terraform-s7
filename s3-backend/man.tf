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


# DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-s7-state-locks"  # Unique name for the table
  billing_mode = "PAY_PER_REQUEST"        # Use on-demand billing for flexibility

  attribute {
    name = "LockID"
    type = "S"  # String type for LockID
  }

  # Define primary key
  hash_key = "LockID"

  tags = {
    Name        = "Terraform State Lock Table"
    Environment = "dev"
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.tf_state_bucket.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}