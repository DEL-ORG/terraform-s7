resource "aws_instance" "my_ec2" {
  depends_on = [
    aws_security_group.allow_ssh
  ]
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  root_block_device {
    volume_size = var.volume_size      
    volume_type = "gp3"   
  }

  tags = {
    Name = var.instance_name
    Create_By   = "Terraform"
    Environment = var.environment
    Project     = "Alpha"
    Company     = "DEL"
  }
}