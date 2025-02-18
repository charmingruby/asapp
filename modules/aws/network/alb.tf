resource "aws_alb" "this" {
  security_groups = [aws_security_group.alb.id]
  subnets         = [aws_subnet.this["pub_a"].id, aws_subnet.this["pub_b"].id]
  tags            = merge(var.common_tags, { Name = format("%s-alb", var.common_tags.service_name) })
}


resource "aws_lb_target_group" "this" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id

  health_check {
    path              = "/"
    healthy_threshold = 2
  }

  tags = merge(var.common_tags, { Name = format("%s-alb-tg", var.common_tags.service_name) })
}


resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_alb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
