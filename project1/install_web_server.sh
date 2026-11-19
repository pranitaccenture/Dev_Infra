#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>Terraform AWS Web Server</title>
<style>
   body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; background-color: #f4f4f9; }
   h1 { color: #232f3e; }
   p { color: #555; font-size: 18px; }
</style>
</head>
<body>
<h1>Success! Linux EC2 Web Server Deployed via Terraform by Pranit Das</h1>
<p>Hosted on AWS using Terraform.</p>
</body>
</html>
EOF