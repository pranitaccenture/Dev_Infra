# Fetch the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
 most_recent = true
 owners      = ["amazon"]
 filter {
   name   = "name"
   values = ["amzn2-ami-hvm-*-x86_64-gp2"]
 }
}
# Deploy the EC2 Instance
resource "aws_instance" "web_server" {
 ami           = data.aws_ami.amazon_linux.id
 instance_type = var.instance_type
 tags = {
   Name = var.instance_name
 }
}
# Create an SNS Topic for Alarm Notifications
resource "aws_sns_topic" "cpu_alerts" {
 name = "ec2-cpu-spike-alerts"
}
# Create the CloudWatch CPU Alarm
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
 alarm_name          = "ec2-high-cpu-utilization"
 comparison_operator = "GreaterThanThreshold"
 evaluation_periods  = 1
 metric_name         = "CPUUtilization"
 namespace           = "AWS/EC2"
 period              = 60
 statistic           = "Average"
 threshold           = var.cpu_threshold
 alarm_description   = "Triggers when EC2 CPU exceeds ${var.cpu_threshold}%"
 alarm_actions       = [aws_sns_topic.cpu_alerts.arn]
 dimensions = {
   InstanceId = aws_instance.web_server.id
 }
}