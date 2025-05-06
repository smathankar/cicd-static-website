variable "prefix" {
  type        = string
}

variable "environment" {
  type        = string
}


variable "bucket_artifact_name" {
  type = string
}

# variable "ssm_parameter_arn" {
#   type = string
# }

variable "codebuild_container_image" {
  type   = string
}

variable "codebuild_compute_type" {
  type        = string
}

variable "github_branch_name" {
  type        = string
}

variable "github_repository_username" {
  type = string
}

variable "github_repository_name" {
  type = string
}

variable "github_token_secret_manager_name" {
type = string
}
variable "cloudfront_distribution_id" {
type = string
}
