# variables.tf
variable "aws_region" {
  description = "The AWS region where the instance will be created."
  type        = string
  default     = "us-east-1"
}

variable "windows_ami_id" {
  description = "The AMI ID for the Windows instance."
  type        = string
}

variable "instance_type" {
  description = "The type of the instance to start."
  type        = string
  default     = "t2.micro"
}

variable "root_volume_size" {
  description = "The size of the root volume in GB."
  type        = number
  default     = 30
}

variable "root_volume_type" {
  description = "The type of the root volume (e.g., gp2)."
  type        = string
  default     = "gp2"
}

variable "key_name" {
  description = "The name of the existing key pair to use for SSH access."
  type        = string
}
