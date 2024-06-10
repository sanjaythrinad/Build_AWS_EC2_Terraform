variable "region" {
  description = "VPC name"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "devop-project1-vpv"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "VPC name"
  type        = string
  default     = "devop-project1-subnet"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the first subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the first subnet"
  type        = string
  default     = "us-east-1a"
}

variable "instance_ami" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-04b70fa74e45c3917"
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "server_name" {
  description = "Name tag for the first DevOps server"
  type        = string
  default     = "project-1_server"
}

variable "public_key" {
  description = "AWS Public Key to access the Server"
  type = string
}