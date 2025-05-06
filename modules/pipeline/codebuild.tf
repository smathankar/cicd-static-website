
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
      nodejs: 18
   
    commands:
        # install npm
        - npm install
       
  build:
    commands:
        # run build script
        - npm run build
     
artifacts:
  # include all files required to run the application
  files:
    - public/**/*
    - src/**/*
    - package.json
    - appspec.yml
    - scripts/**/*
EOF
  }
}
