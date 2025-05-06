
resource "aws_codebuild_project" "build_and_deploy" {
  name          = "${var.prefix}-${var.environment}-build-project"
  description   = "Build and Deploy to S3"
  service_role  = aws_iam_role.codebuild_service_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = var.codebuild_compute_type
    image                       = var.codebuild_container_image
    type                        = "LINUX_CONTAINER"
    # environment_variable {
    #   name  = "abc"
    #   value = "xyz"
    # }
    # environment_variable {
    #   name  = "abc"
    #   value = "xyz"
    # }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = <<EOF
version: 0.2

phases:
  install:
    runtime-versions:
      nodejs: 16
    commands:
      - echo Installing dependencies...
      - npm ci

  pre_build:
    commands:
      - echo Running pre-build tasks...

  build:
    commands:
      - echo Building the React app...
      - npx react-scripts build

  post_build:
    commands:
      - echo Build completed.
      - echo Deploying to S3...
      - aws s3 sync build/ s3://${var.bucket_artifact_name}/
      - rm -dir build -f
      - echo Creating CloudFront invalidation...
      - aws cloudfront create-invalidation --distribution-id ${var.cloudfront_distribution_id} --paths "/*"

artifacts:
  files:
    - '**/*'

EOF
  }
}
