variable "common_tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}
