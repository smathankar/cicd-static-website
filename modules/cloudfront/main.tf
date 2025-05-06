locals {
  s3_origin_id   = "${var.static_bucket_name}-origin"
  required_tags = {    
    creator     = data.aws_caller_identity.current.arn 
    }
}

data "aws_caller_identity" "current" {}

#############################################################################

resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  
  enabled = true
  
  origin {
    origin_id                = local.s3_origin_id
    domain_name              = var.s3_bucket_domain
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1"]
    }
  }
 
  default_cache_behavior {
    
    target_origin_id = local.s3_origin_id
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN", "US", "CA"]
    }
  }
  
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  price_class = "PriceClass_All"

  tags = merge(    
    local.required_tags,    
    {     
      Name        = var.cloudfront_name
      Environment = var.environment
    },  
    )
}

#############################################################################