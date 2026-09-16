variable "aws_region" {
  description = "AWS region where the development environment will be deployed."
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Name used to identify the development environment resources."
  type        = string
  default     = "terraform-dev-environment"
}

variable "vpc_cidr" {
  description = "CIDR block for the development VPC."
  type        = string
  default     = "10.123.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public development subnet."
  type        = string
  default     = "10.123.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type for the development environment."
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name used for SSH access."
  type        = string
}
