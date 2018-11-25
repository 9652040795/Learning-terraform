#!/bin/bash

yum install -y httpd
service httpd start
chckconfig httpd on
echo "<h1>Delpoyed by Terraform</h1>" > /var/www/html/index.html







#END