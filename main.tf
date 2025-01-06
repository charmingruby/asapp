module "network" {
  source = "./modules/network"

  common_tags = local.common_tags
  aws_region  = var.aws_region
}

module "compute" {
  source = "./modules/compute"

  autoscaling_sg_id = module.network.sg_autoscaling_id
  instance_key_name = var.ec2_instance_key_name
  instance_type     = var.ec2_instance_type
}
