provider "aws" {
  region = "us-east-1"  # Change to your preferred AWS region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-12345"                        

  tags = {
    Name        = ""
  }
}