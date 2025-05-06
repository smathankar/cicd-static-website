
resource "aws_iam_role" "codepipeline_service_role" {
  name = "${var.prefix}-${var.environment}-CodePipeline-Service-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "codepipeline.amazonaws.com"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "codepipeline_policy" {
  name = "${var.prefix}-${var.environment}-CodePipeline_Service_Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
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
      # {
      #   Sid    = "SSMParameterStore"
      #   Effect = "Allow"
      #   Action = [
      #     "ssm:DescribeParameters",
      #     "ssm:GetParameter",
      #     "ssm:GetParameterHistory",
      #     "ssm:GetParameters",
      #     "ssm:GetParametersByPath"
      #   ]
      #   Resource = [
      #     "${var.ssm_parameter_arn}",
      #   ]
      # },
      {
        Sid    = "CodeBuildPolicy"
        Effect = "Allow"
        Action = [
            "codebuild:StartBuild",
            "codebuild:BatchGetBuilds"
        ]
        Resource = "arn:aws:codebuild:*:*:project/*"
      },
      # {
      #   Sid    = "CodeStarConnection"
      #   Effect = "Allow"
      #   Action = [
      #       "codestar-connections:UseConnection"
      #   #   "codestar:Describe*", "codestar:List*", "codestar:Update*",
      #   #   "codestar-connections:Get*", "codestar-connections:List*",
      #   #   "codestar-connections:PassConnection",
      #   #   "codestar-connections:RegisterAppCode",
      #   #   "codestar-connections:StartAppRegistrationHandshake",
      #   #   "codestar-connections:StartOAuthHandshake",
      #   #   "codestar-connections:UseConnection"
      #   ]
      #   Resource = var.codestar_connection_arn
      # }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_pipeline_policy" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}
