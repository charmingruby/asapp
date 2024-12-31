module "vpc" {
  source = "./modules/network"

  common_tags = local.common_tags
}
