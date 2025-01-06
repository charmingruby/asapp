output "vpc_id" {
  value = aws_vpc.this.id
}

output "igw_id" {
  value = aws_internet_gateway.this.id
}

output "subnet_ids" {
  value = local.subnet_ids
}
output "public_subnet_ids" {
  value = [for k, v in local.subnet_ids : v if contains(split("-", k), "public")]
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

output "route_table_association_ids" {
  value = [for k, v in aws_route_table_association.this : v.id]
}

output "sg_web_id" {
  value = aws_security_group.web.id
}

output "sg_db_id" {
  value = aws_security_group.db.id
}

output "alb_id" {
  value = aws_alb.this.id
}

output "sg_autoscaling_id" {
  value = aws_security_group.autoscaling.id
}

output "aws_lb_target_group_id" {
  value = aws_lb_target_group.this.id
}
