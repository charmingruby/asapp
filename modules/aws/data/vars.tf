variable "private_subnet_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "db_sg_id" {
  type        = string
  description = "Database security group ID"
}

variable "common_tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}
