resource "aws_ecr_repository" "darthdataditch" {
  name                 = "darthdataditch-ecr" 
  image_tag_mutability = "MUTABLE"           
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    managedby = "vader"
  }
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

output "darthdataditch-ecr_url" {
  value = aws_ecr_repository.darthdataditch.repository_url
}
