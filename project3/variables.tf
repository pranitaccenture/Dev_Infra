variable "aws_region" {
 description = "AWS region to deploy resources"
 type        = string
 default     = "ap-south-1"
}
variable "instance_type" {
 description = "EC2 instance type"
 type        = string
 default     = "t2.micro"
}
variable "cpu_threshold" {
 description = "CPU utilization percentage that triggers the CloudWatch alarm"
 type        = number
 default     = 70
}
variable "instance_name" {
 description = "Name tag for the EC2 instance"
 type        = string
 default     = "CloudWatch-Monitored-EC2"
}