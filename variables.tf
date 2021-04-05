variable "aws_region" {
  description = "Define AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Define VPC name"
  type        = string
  default     = "VPC-TF"
}

variable "vpc_cidr" {
  description = "VPC subnet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "default_cidr" {
  description = "Define default cidr"
  type        = string
  default     = "0.0.0.0/0"
}

variable "aws_instance_type" {
  description = "Define EC2 instance type for all instances in the project"
  type        = string
  default     = "t2.micro"
}

variable "asg_desired_capacity" {
  description = "Define how many WEB instances should we have"
  type        = number
  default     = 3
}

variable "ec2_key_name" {
    description = "EC2 key name"
    type = string
    default = "GenericKP"
}
