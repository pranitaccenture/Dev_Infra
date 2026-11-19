variable "aws_region" {
 description = "AWS region where the S3 bucket will be created"
 type        = string
 default     = "ap-south-1"
}
variable "bucket_name" {
 description = "Globally unique name for the S3 static website bucket"
 type        = string
 default     = "pranit-das-dev-infra-project2-19112026" # Change this to a unique name
}