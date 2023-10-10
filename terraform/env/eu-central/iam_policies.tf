resource "aws_iam_policy" "allow_assume_alb_ingress_controller" {
  name        = "AllowAssumeAlbIngressController-${var.region}"
  description = "Allows EKS nodes to assume the ALB Ingress Controller role"
  tags = {
    managedby= "vader"
  }

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRoleWithWebIdentity",
        Resource = "arn:aws:iam::433663489437:role/alb-ingress-controller"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_allow_assume_to_node_role" { #TODO: remove if unneeded
  policy_arn = aws_iam_policy.allow_assume_alb_ingress_controller.arn
  role       = aws_iam_role.eks_node_role.name

}


resource "aws_iam_policy" "AWSLoadBalancerControllerIAMPolicy" {
    name = "AWSLoadBalancerControllerIAMPolicy-${var.region}"
    tags = {
      managedby = "vader"
    }
    policy = file("policies/AWSLoadBalancerControllerIAMPolicy.json")

}

resource "aws_iam_policy" "s3_holocron-archives_policy" {
  name        = "S3HolocronArchivesPolicy-${var.region}"
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
        Resource = ["${data.terraform_remote_state.global.outputs.s3_holocron-archives_bucket_arn}"]
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
        Resource = ["${data.terraform_remote_state.global.outputs.s3_holocron-archives_bucket_arn}/*"]
      }
    ]
  })
}

output "s3_put_get_list_policy_arn" {
  value = aws_iam_policy.s3_holocron-archives_policy.arn
}

