#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
echo "<h1>WELCOME PAGE from $(hostname -f)</h1>" > /var/www/html/index.html