resource "aws_iam_policy" "s3_holocron-archives_policy" {
  name        = "S3HolocronArchivesPolicy"
  description = "Use the Force to put, get, and list items in the galaxy of the holocron-archives S3 bucket"
  tags = {
    managedby = "vader"
  }

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:PutObject", "s3:GetObject"],
        Effect   = "Allow",
        Resource = "${aws_s3_bucket.holocron-archives.arn}/*"
      },
      {
        Action   = ["s3:ListBucket"],
        Effect   = "Allow",
        Resource = "${aws_s3_bucket.holocron-archives.arn}/"
      }
    ]
  })
}

output "s3_put_get_list_policy_arn" {
  value = aws_iam_policy.s3_holocron-archives_policy.arn
}