#!/bin/bash

function jenkins_installation {
    # Set non-interactive frontend for package installation
    export DEBIAN_FRONTEND="noninteractive"
    
    # Install tzdata and update system
    sudo apt-get install -y tzdata
    sudo apt-get update

    # Install required tools and utilities
    sudo apt-get install curl -y 
    sudo apt-get install wget -y    
    sudo apt-get install vim -y

    # Set vim as default text editor
    sudo update-alternatives --set editor /usr/bin/vim.basic
    sudo update-alternatives --set vi /usr/bin/vim.basic

    # Install OpenJDK 17
    sudo apt-get install fontconfig openjdk-17-jre -y
    java -version

    # Add Jenkins GPG key and repository
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

    # Update package list and install Jenkins
    sudo apt-get update
    sudo apt-get install jenkins -y

    # Start Jenkins service and enable on boot
    sudo systemctl start jenkins
    sudo systemctl enable jenkins

    # Verify Jenkins service status
    sudo systemctl status jenkins --no-pager
}

# Call the function
jenkins_installation
