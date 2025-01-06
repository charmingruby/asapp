variable "public_subnet_ids" {
  description = "The IDs of the public subnets"
  type        = list(string)
}

variable "autoscaling_sg_id" {
  description = "The ID of the autoscaling security group"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
}

variable "instance_key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string
}
variable "load_balancer_tg_id" {
  description = "The ID of the target group for the load balancer"
  type        = string
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "common_tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}
