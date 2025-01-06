variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-west-1"
}

variable "ec2_instance_type" {
  type        = string
  description = "The type of instance to launch"
  default     = "t3.micro"
}

variable "ec2_instance_key_name" {
  type        = string
  description = "The name of the key pair to use for the instance"
  default     = "gustavo-asapp"
}
