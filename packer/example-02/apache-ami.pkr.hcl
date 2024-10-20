# Packer block for required plugin
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Source block with dynamic AMI selection
source "amazon-ebs" "web-server" {
  ami_name                       = "web2-server-ami-{{timestamp}}"
  associate_public_ip_address    = true
  force_delete_snapshot          = true
  instance_type                  = "t2.micro"
  region                         = "us-east-1"
  vpc_id                         = "vpc-068852590ea4b093b"
  subnet_id                      = "subnet-096d45c28d9fb4c14"
  ssh_username                   = "ec2-user" # Amazon Linux default username
  
  # Custom tags
  tags = {
    "teams"          = "DEL"
    "environment"    = "development"
    "project"        = "alpha"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }

  # Dynamic source AMI selection for Amazon Linux
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2" # Filter for Amazon Linux 2
      root-device-type    = "ebs"
      virtualization-type  = "hvm"
    }
    most_recent = true
    owners      = ["137112412989"] # Amazon Linux 2 Owner ID
  }

  # Block device mapping
  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/xvda"
    volume_size           = "30"
    volume_type           = "gp2"
  }
}

# Build block for web server
build {
  name = "web-server"
  sources = [
    "source.amazon-ebs.web-server"
  ]
  
  # Provisioners for setting up Apache
  provisioner "file" {
    source      = "./install_apache.sh" # Path to your script
    destination = "/tmp/install_apache.sh"
  }

  provisioner "shell" {
    inline = [
      "chmod +x /tmp/install_apache.sh",
      "bash /tmp/install_apache.sh"
    ]
  }
}