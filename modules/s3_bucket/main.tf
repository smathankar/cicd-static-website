

#############################################################################
# S3 Bucket to store react app build artifacts

resource "aws_s3_bucket" "s3_static_website" {
  bucket = "${var.static_bucket_name}-${var.environment}"
  #force_destroy = true

  tags = merge(    
    local.required_tags,    
    {     
    Name        = var.static_bucket_name
    Environment = var.environment
    },  
    )
}

resource "aws_s3_bucket_public_access_block" "static_site_bucket_public_access" {
  bucket = aws_s3_bucket.s3_static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "static_config" {
  bucket = aws_s3_bucket.s3_static_website.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3_static_website.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowGetObj",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.s3_static_website.id}/*"
    }
  ]
}
POLICY
}

#############################################################################
