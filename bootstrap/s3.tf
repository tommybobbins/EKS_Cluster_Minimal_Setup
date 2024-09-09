resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "${var.common_tags.Project}-${var.common_tags.env}"
  tags = {
    Name = "S3 Remote Terraform State Store"
  }
}

resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_object_lock_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  object_lock_enabled = "Enabled"
}