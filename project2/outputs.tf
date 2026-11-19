output "website_endpoint" {
 description = "Public URL for the S3 static website"
 value       = "http://${aws_s3_bucket_website_configuration.website_config.website_endpoint}"
}
output "bucket_id" {
 description = "Name of the created S3 bucket"
 value       = aws_s3_bucket.website_bucket.id
}