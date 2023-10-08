resource "aws_s3_bucket" "holocron-archives" {
  bucket        = "holocron-archives"
  force_destroy = false
  tags = {
    managedby = "vader"
  }
}

resource "aws_s3_bucket_accelerate_configuration" "holocron-archives-accelerate" {
  bucket = aws_s3_bucket.holocron-archives.bucket
  status = "Enabled"
}

output "s3_holocron-archives_bucket_name" {
  value = aws_s3_bucket.holocron-archives.bucket
}

output "s3_holocron-archives_bucket_arn" {
  value = aws_s3_bucket.holocron-archives.arn
}
