resource "aws_autoscaling_group" "this" {
  name                      = format("%s-asg", var.common_tags.service_name)
  vpc_zone_identifier       = var.public_subnet_ids
  min_size                  = 2
  max_size                  = 5
  health_check_grace_period = 240
  health_check_type         = "ELB"
  force_delete              = true

  target_group_arns = [var.load_balancer_tg_id]

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }
}

resource "aws_autoscaling_policy" "scaleup" {
  name                   = "scale-up"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "180"
  policy_type            = "SimpleScaling"
}

resource "aws_autoscaling_policy" "scaledown" {
  name                   = "scale-down"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "180"
  policy_type            = "SimpleScaling"
}
