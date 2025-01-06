module "aws_network" {
  source = "./modules/aws/network"

  common_tags = local.common_tags
  aws_region  = var.aws_region
}

module "aws_compute" {
  source = "./modules/aws/compute"

  autoscaling_sg_id   = module.aws_network.sg_autoscaling_id
  instance_key_name   = var.ec2_instance_key_name
  instance_type       = var.ec2_instance_type
  public_subnet_ids   = module.aws_network.public_subnet_ids
  load_balancer_tg_id = module.aws_network.aws_lb_target_group_id
  aws_region          = var.aws_region
  common_tags         = local.common_tags
}

module "aws_data" {
  source = "./modules/aws/data"

  aws_region         = var.aws_region
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  private_subnet_ids = module.aws_network.private_subnet_ids
  common_tags        = local.common_tags
  db_sg_id           = module.aws_network.sg_db_id
}
