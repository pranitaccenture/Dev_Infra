variable "aws_region" {
 description = "AWS region"
 type        = string
 default     = "ap-south-1"
}
variable "iam_username" {
 description = "Name of the IAM user"
 type        = string
 default     = "pranit-das-s3-user"
}
variable "s3_controlled_policy" {
 description = "JSON policy granting controlled S3 read-only access"
 type        = string
 default     = <<-EOT
 {
   "Version": "2012-10-17",
   "Statement": [
     {
       "Sid": "ControlledS3ReadOnly",
       "Effect": "Allow",
       "Action": [
         "s3:GetObject",
         "s3:ListBucket"
       ],
       "Resource": [
         "arn:aws:s3:::pranit-das-accenture-19112026",
         "arn:aws:s3:::pranit-das-accenture-19112026/*"
       ]
     }
   ]
 }
 EOT
}