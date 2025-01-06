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
