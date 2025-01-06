data "aws_ami" "ubuntu" {
  owners      = ["amazon"]
  most_recent = true
  name_regex  = "ubuntu"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_template" "this" {
  name_prefix   = "terraform-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.instance_key_name
  user_data     = filebase64("./modules/compute/ec2_setup.sh")

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [var.autoscaling_sg_id]
  }

  tags = merge(var.common_tags, { Name = format("%s-ec2", var.common_tags.service_name) })
}
