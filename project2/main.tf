# 1. Create the S3 Bucket
resource "aws_s3_bucket" "website_bucket" {
 bucket = var.bucket_name
}
# 2. Enable Static Website Hosting
resource "aws_s3_bucket_website_configuration" "website_config" {
 bucket = aws_s3_bucket.website_bucket.id
 index_document {
   suffix = "index.html"
 }
}
# 3. Disable "Block Public Access" Settings
resource "aws_s3_bucket_public_access_block" "public_access" {
 bucket = aws_s3_bucket.website_bucket.id
 block_public_acls       = false
 block_public_policy     = false
 ignore_public_acls      = false
 restrict_public_buckets = false
}
# 4. Attach Bucket Policy for Public Read Access
resource "aws_s3_bucket_policy" "public_read_policy" {
 bucket = aws_s3_bucket.website_bucket.id
 depends_on = [aws_s3_bucket_public_access_block.public_access]
 policy = jsonencode({
   Version = "2012-10-17"
   Statement = [
     {
       Sid       = "PublicReadGetObject"
       Effect    = "Allow"
       Principal = "*"
       Action    = "s3:GetObject"
       Resource  = "${aws_s3_bucket.website_bucket.arn}/*"
     }
   ]
 })
}
# 5. Upload index.html to the Bucket
resource "aws_s3_object" "index_html" {
 bucket       = aws_s3_bucket.website_bucket.id
 key          = "index.html"
 source       = "${path.module}/index.html"
 content_type = "text/html"
 etag         = filemd5("${path.module}/index.html")
}