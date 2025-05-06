output "static_bucket_website_arn" {
  value = aws_s3_bucket.s3_static_website.arn
}
output "static_bucket_website_id" {
  value = aws_s3_bucket.s3_static_website.id
}
output "static_bucket_website_domain_name" {
  value = aws_s3_bucket.s3_static_website.bucket_domain_name
}
output "static_bucket_website_domain" {
  value = aws_s3_bucket_website_configuration.static_config.website_domain
}
output "static_bucket_website_endpoint" {
  value = aws_s3_bucket_website_configuration.static_config.website_endpoint
}
