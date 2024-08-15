# main.tf

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "windows_instance" {
  ami           = var.windows_ami_id
  instance_type = var.instance_type

  tags = {
    Name = "om2_WindowsInstance"
  }

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }

  # Ensure the instance gets an Elastic IP
  associate_public_ip_address = true

  # Configure the security group
  vpc_security_group_ids = [aws_security_group.sg.id]
  
  key_name = var.key_name  # Reference the existing key pair name here


resource "aws_security_group" "sg" {
  name        = "windows_sg"
  description = "Allow inbound traffic for Windows instance"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
