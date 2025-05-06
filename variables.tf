variable "target_account_region" {
  description = "The AWS region to create the resources in"
  type        = string
}

variable "environment" {
  description = "The environment for the resources (e.g., dev, prod)."
  type        = string
}

##################################################

# Pipeline
variable "prefix" {
  description = "Prefix for pipeline resource names"
  type        = string
}

variable "codebuild_container_image" {
  description = "value of the codebuild container image"
  type = string
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
}

variable "codebuild_compute_type" {
  description = "value of the codebuild compute type"
  type = string
  default     = "BUILD_GENERAL1_SMALL"
}

variable "github_branch_name" {
  description = "Branch name to build from"
  type        = string
  default     = "main"  
}

variable "github_repository_username" {
  description = "Username of Github Repo"
  type = string
  default = "smathankar"
}

variable "github_repository_name" {
  description = "Repo of Github Repo"
  type = string
  default = "cicd_app_deploy"
}

variable "github_token_secret_manager_name" {
type = string
}


# S3 Bucket

variable "static_bucket_name" {
  type = string
}


# CloudFront

variable "cloudfront_name" {
  type = string
}



