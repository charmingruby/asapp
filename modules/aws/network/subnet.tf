resource "aws_subnet" "this" {
  for_each = {
    "pub_a" : {
      cidr_block        = "192.168.0.0/24"
      availability_zone = "${var.aws_region}a"
      name              = "public-a"
    },
    "pub_b" : {
      cidr_block        = "192.168.1.0/24"
      availability_zone = "${var.aws_region}b"
      name              = "public-b"
    },
    "priv_a" : {
      cidr_block        = "192.168.2.0/24"
      availability_zone = "${var.aws_region}a"
      name              = "private-a"
      }, "priv_b" : {
      cidr_block        = "192.168.3.0/24"
      availability_zone = "${var.aws_region}b"
      name              = "private-b"
    }
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags              = merge(var.common_tags, { Name = format("%s-%s-subnet", var.common_tags.service_name, each.value.name) })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(var.common_tags, { Name = format("%s-public-rt", var.common_tags.service_name) })
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags   = merge(var.common_tags, { Name = format("%s-private-rt", var.common_tags.service_name) })
}


resource "aws_route_table_association" "this" {
  for_each = local.subnet_ids

  subnet_id      = each.value
  route_table_id = substr(split("-", each.key)[1], 0, 3, ) == "pub" ? aws_route_table.public.id : aws_route_table.private.id
}
