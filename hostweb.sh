#!/bin/bash
set -e
echo "Checking whether Nginx is installed..."
if command -v nginx >/dev/null 2>&1
then
    echo "Nginx is installed."
    if systemctl is-active --quiet nginx
    then
        echo "Nginx service is running."
    else
        echo "Nginx service is not running."
        echo "Starting Nginx..."
        sudo systemctl start nginx
    fi
else
    echo "Nginx is not installed."
    echo "Installing Nginx..."
    sudo apt update
    sudo apt install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
fi
echo

read -p "enter the website url: " url
read -p "enter the zip file name: " name
wget -O $name.zip $url
unzip $name.zip
ls
pwd
read -p "Enter the website directory path: " path
sudo cp -r $path/* /var/www/html
sudo systemctl restart nginx
echo "Website hosted successfully!"
