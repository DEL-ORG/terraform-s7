#!/bin/bash

# Function to install Apache HTTP Server
function install_apache {
    # Update the package list and upgrade existing packages
    echo "Updating package list..."
    sudo yum update -y
    
    # Install wget and unzip
    echo "Installing wget and unzip..."
    sudo yum install -y wget unzip
    
    # Install Apache HTTP Server (httpd)
    echo "Installing Apache HTTP Server..."
    sudo yum install -y httpd
    
    # Start Apache and enable it to run on boot
    echo "Starting Apache HTTP Server..."
    sudo systemctl start httpd
    sudo systemctl enable httpd

    # Download and extract the website files
    echo "Downloading website files..."
    wget https://linux-devops-course.s3.amazonaws.com/phone.zip -O /tmp/phone.zip
    echo "Extracting website files..."
    sudo unzip /tmp/phone.zip -d /var/www/html/
    
    # Set permissions for the web directory
    echo "Setting permissions for the web directory..."
    sudo chown -R apache:apache /var/www/html/*
    
    # Display the status of Apache
    echo "Apache HTTP Server status:"
    sudo systemctl status httpd
}

# Call the install_apache function
install_apache
