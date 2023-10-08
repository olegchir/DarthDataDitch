resource "aws_ecr_repository" "darthdataditch" {
  name                 = "darthdataditch-ecr" 
  image_tag_mutability = "MUTABLE"           
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    managedby = "terraform"
  }
}

output "darthdataditch-ecr_url" {
  value = aws_ecr_repository.darthdataditch.repository_url
}
