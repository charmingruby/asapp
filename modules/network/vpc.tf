resource "aws_vpc" "this" {
  cidr_block = "192.168.0.0/16"
  tags = merge(
    var.common_tags, { Name = format("%s-vpc", var.common_tags.service_name) }
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.common_tags, { Name = format("%s-igw", var.common_tags.service_name) }
  )
}
