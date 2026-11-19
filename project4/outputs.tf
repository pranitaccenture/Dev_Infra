output "user_name" {
 value = aws_iam_user.controlled_user.name
}
output "user_arn" {
 value = aws_iam_user.controlled_user.arn
}
output "attached_policy_arn" {
 value = aws_iam_policy.s3_read_policy.arn
}