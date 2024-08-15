# outputs.tf

output "instance_id" {
  description = "The ID of the created EC2 instance."
  value       = aws_instance.windows_instance.id
}

output "instance_public_ip" {
  description = "The public IP address of the created EC2 instance."
  value       = aws_instance.windows_instance.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the created EC2 instance."
  value       = aws_instance.windows_instance.private_ip
}

output "instance_ami" {
  description = "The AMI ID used for the instance."
  value       = var.windows_ami_id
}

output "instance_type" {
  description = "The instance type of the created EC2 instance."
  value       = aws_instance.windows_instance.instance_type
}

output "security_group_id" {
  description = "The ID of the security group associated with the instance."
  value       = aws_security_group.sg.id
}