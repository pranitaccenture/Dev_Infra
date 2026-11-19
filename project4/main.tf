# 1. Create the IAM User
resource "aws_iam_user" "controlled_user" {
 name = var.iam_username
 tags = {
   ManagedBy = "Terraform"
   Purpose   = "Controlled S3 Access"
 }
}
# 2. Create the Controlled Policy from the Variable
resource "aws_iam_policy" "s3_read_policy" {
 name        = "${var.iam_username}-s3-read-policy"
 description = "Controlled S3 read-only permissions"
 policy      = var.s3_controlled_policy
}
# 3. Attach the Policy to the IAM User
resource "aws_iam_user_policy_attachment" "user_policy_attach" {
 user       = aws_iam_user.controlled_user.name
 policy_arn = aws_iam_policy.s3_read_policy.arn
}