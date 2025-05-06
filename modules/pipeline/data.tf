
data "aws_caller_identity" "current" {}

data "aws_secretsmanager_secret_version" "github_token_version" {
  secret_id = aws_secretsmanager_secret.github_token.id
}