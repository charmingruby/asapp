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

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "johndoe_db"
}

variable "db_username" {
  description = "The username for the database"
  type        = string
  default     = "johndoe"
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  default     = "johndoe_password"
}
