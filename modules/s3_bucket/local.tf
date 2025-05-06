locals {
  required_tags = {    
    creator     = data.aws_caller_identity.current.arn 
    }
}

