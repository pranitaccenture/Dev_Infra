variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "web_server_port" {
  description = "Port for web server (not 22 or 3389)"
  type        = number
  default     = 80
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "web-server"
}

variable "enable_https" {
  description = "Enable HTTPS port 443"
  type        = bool
  default     = false
}

variable "web_server_software" {
  description = "Web server software to install (apache or nginx)"
  type        = string
  default     = "nginx"
  
  validation {
    condition     = contains(["apache", "nginx"], var.web_server_software)
    error_message = "Must be either 'apache' or 'nginx'."
  }
}
