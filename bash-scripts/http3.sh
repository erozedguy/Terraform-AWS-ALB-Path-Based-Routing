#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
sudo mkdir /var/www/html/app2
echo "<h1>APP2 from $(hostname -f)</h1>" > /var/www/html/app2/index.html