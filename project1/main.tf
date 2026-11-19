# 1. Create a Custom VPC

resource "aws_vpc" "web_vpc" {
 cidr_block           = var.vpc_network_address_space
 enable_dns_hostnames = true
 tags = {
   Name = "${var.project_name}-VPC"
 }
}
# 2. Create a Public Subnet
resource "aws_subnet" "public_subnet" {
 vpc_id                  = aws_vpc.web_vpc.id
 cidr_block              = var.subnet_address_space
 map_public_ip_on_launch = true
 tags = {
   Name = "${var.project_name}-Public-Subnet"
 }
}
# 3. Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
 vpc_id = aws_vpc.web_vpc.id
 tags = {
   Name = "${var.project_name}-IGW"
 }
}
# 4. Create a Route Table & Associate with Public Subnet
resource "aws_route_table" "public_rt" {
 vpc_id = aws_vpc.web_vpc.id
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
 }
 tags = {
   Name = "${var.project_name}-Public-RT"
 }
}
resource "aws_route_table_association" "public_assoc" {
 subnet_id      = aws_subnet.public_subnet.id
 route_table_id = aws_route_table.public_rt.id
}
# 5. Create Security Group (Allow HTTP & SSH)
resource "aws_security_group" "web_sg" {
 name        = "${var.project_name}-sg"
 description = "Allow HTTP and SSH traffic"
 vpc_id      = aws_vpc.web_vpc.id
 ingress {
   description = "HTTP from anywhere"
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
   description = "SSH from anywhere"
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
   Name = "${var.project_name}-SG"
 }
}
# 6. Fetch Latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
 most_recent = true
 owners      = ["amazon"]
 filter {
   name   = "name"
   values = ["al2023-ami-2023.*-x86_64"]
 }
}
# 7. Launch EC2 Instance with User Data Script
resource "aws_instance" "web_server" {
 ami                    = data.aws_ami.amazon_linux.id
 instance_type          = var.instance_type
 subnet_id              = aws_subnet.public_subnet.id
 vpc_security_group_ids = [aws_security_group.web_sg.id]
 user_data              = file("install_web_server.sh")
 tags = {
   Name = "${var.project_name}-EC2"
 }
}