resource "aws_secretsmanager_secret" "github_token" {
  name        = var.github_token_secret_manager_name
  description = "GitHub token for CodePipeline"
}