target_account_region     = "us-east-1"
environment               = "dev"

# Pipeline
prefix                      = "demo"
codebuild_container_image   = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
codebuild_compute_type      = "BUILD_GENERAL1_SMALL"
github_branch_name          = "main"
github_repository_username  = "smathankar"
github_repository_name      = "cicd_app_deploy"
github_token_secret_manager_name  = "github-token1"

# S3 Bucket
static_bucket_name        = "react-app-56528776824"

# CloudFront
cloudfront_name           = "demo-cloudfront"
