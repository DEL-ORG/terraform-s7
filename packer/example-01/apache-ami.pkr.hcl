packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "learn-packer-linux-aws-{{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami    = "ami-06b21ccaeff8cd686"
  ssh_username = "ec2-user"
  associate_public_ip_address = true
  # source_ami_filter {
  #   filters = {
  #     name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
  #     root-device-type    = "ebs"
  #     virtualization-type = "hvm"
  #   }
  #   most_recent = true
  #   owners      = ["099720109477"]
  # }
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  # Upload the shell script to the instance
  provisioner "file" {
    source      = "./install_apache.sh"  # The script on your local machine
    destination = "/tmp/install_apache.sh" # Where the script will be uploaded on the instance
  }

  # Run the shell script on the instance
  provisioner "shell" {
    inline = [
      "chmod +x /tmp/install_apache.sh", # Make the script executable
      "sudo bash /tmp/install_apache.sh"      # Run the script
    ]
  }
}
