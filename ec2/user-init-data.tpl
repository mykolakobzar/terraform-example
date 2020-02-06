#!/bin/bash
apt update && apt install nginx -y
echo "${hello_message}!" > /var/www/html/index.nginx-debian.html
