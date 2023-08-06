resource "aws_ecr_repository" "ecr" {
  name                 = "bar"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "production"
  }
  
 
}

resource "aws_iam_role" "ecr_access" {
  name = "ecr_access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Environment = "production"
  }

  description = "IAM role for EC2 instances to access ECR repository"
}

resource "aws_iam_policy" "ecr_access_policy" {
  name = "ecr_access_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage" # Allow EC2 instances to push images to ECR repository
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Environment = "production"
  }

  description = "IAM policy for granting access to ECR repository"
}

resource "aws_iam_role_policy_attachment" "ecr_access_attachment" {
  policy_arn = aws_iam_policy.ecr_access_policy.arn
  role       = aws_iam_role.ecr_access.name
}
