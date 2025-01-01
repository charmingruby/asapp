module "vpc" {
  source = "./modules/network"

  common_tags = local.common_tags
  aws_region  = var.aws_region
}
