locals {
  environment   = var.environment
  account_id    = data.aws_caller_identity.current.account_id
  prefix        = var.prefix
  required_tags = {    
    creator     = data.aws_caller_identity.current.arn
    }
}
