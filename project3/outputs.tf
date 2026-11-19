output "instance_id" {
 description = "ID of the deployed EC2 instance"
 value       = aws_instance.web_server.id
}
output "public_ip" {
 description = "Public IP address of the EC2 instance"
 value       = aws_instance.web_server.public_ip
}
output "cloudwatch_alarm_name" {
 description = "Name of the CloudWatch CPU alarm"
 value       = aws_cloudwatch_metric_alarm.cpu_high.alarm_name
}
output "sns_topic_arn" {
 description = "ARN of the SNS topic for CPU alerts"
 value       = aws_sns_topic.cpu_alerts.arn
}