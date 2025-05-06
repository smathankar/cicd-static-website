
module "pipeline" {
  source                    = "./modules/pipeline"
  
  prefix                    = var.prefix
  environment               = var.environment
  bucket_artifact_name      = module.s3_bucket.static_bucket_website_id
#   ssm_parameter_arn         = var.ssm_parameter_arn
  codebuild_container_image = var.codebuild_container_image
  codebuild_compute_type    = var.codebuild_compute_type
  github_branch_name        = var.github_branch_name
  github_repository_username = var.github_repository_username
  github_repository_name    = var.github_repository_name
  github_token_secret_manager_name = var.github_token_secret_manager_name
  
  depends_on = [ module.s3_bucket ]
}

module "s3_bucket" {
  source                = "./modules/s3_bucket"
  static_bucket_name    = var.static_bucket_name
  environment           = var.environment
}

module "cloudfront" {
  source               = "./modules/cloudfront"
  static_bucket_name   = module.s3_bucket.static_bucket_website_id
  s3_bucket_domain     = module.s3_bucket.static_bucket_website_endpoint
  environment          = var.environment
  cloudfront_name      = var.cloudfront_name
  
  depends_on = [ module.s3_bucket ]
}

