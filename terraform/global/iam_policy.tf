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
        Action   = ["s3:ListBucket"],
        Effect   = "Allow",
        Resource = ["${aws_s3_bucket.holocron-archives.arn}"]
      },
      {
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListMultipartUploadParts",
          "s3:AbortMultipartUpload",
          "s3:ListBucketMultipartUploads",
        ],
        Effect   = "Allow",
        Resource = ["${aws_s3_bucket.holocron-archives.arn}/*"]
      }
    ]
  })
}

output "s3_put_get_list_policy_arn" {
  value = aws_iam_policy.s3_holocron-archives_policy.arn
}

resource "aws_ecr_lifecycle_policy" "darthdataditch" {
  repository = aws_ecr_repository.darthdataditch.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 10 images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

output "aws_ecr_lifecycle_policy_darthdataditch_arn" {
  value = aws_iam_policy.s3_holocron-archives_policy.arn
}