
resource "aws_iam_role" "codebuild_service_role" {
  name = "${var.prefix}-${var.environment}-CodeBuild-Service-Role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "codebuild_policy" {
  name = "${var.prefix}-${var.environment}-CodeBuild-Service-Role"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
    #   {
    #     Sid    = "AssumeDeploymentExecutionRoles"
    #     Effect = "Allow"
    #     Action = ["sts:AssumeRole"]
    #     Resource = [
    #       "arn:aws:iam::*:role/${var.codepipeline_assume_role_name}"
    #     ]   
    #   },
      {
        Sid    = "CloudWatchLogs"
        Effect = "Allow"
        Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ]
        Resource = [
          "arn:aws:logs:*:${local.account_id}:log-group:/aws/codebuild/*",
          "arn:aws:logs:*:${local.account_id}:log-group:/aws/codebuild/*:*"
        ]
      },
      {
        Sid    = "S3BucketAccess"
        Effect = "Allow"
        Action = [
            "s3:Describe*",
            "s3:Get*",
            "s3:List*",
            "s3:PutObject"
        ]
        Resource = [
          "arn:aws:s3:::${var.bucket_artifact_name}*",
          "arn:aws:s3:::${var.bucket_artifact_name}*/*"
        ]
      },
      {
        Sid    = "KMSPermissions"
        Effect = "Allow"
        Action = [
            "kms:Decrypt",
            "kms:DescribeKey",
            "kms:Encrypt",
            "kms:GetKeyPolicy",
            "kms:ListKeys"
        ]
        Resource = "*"
      },
      {
        Sid    = "CloudFrontInvalidation"
        Effect = "Allow"
        Action = [
            "cloudfront:CreateInvalidation"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_codebuild_policy" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}
