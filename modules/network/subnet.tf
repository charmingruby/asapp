resource "aws_subnet" "this" {
  for_each = {
    "pub_a" : {
      cidr_block        = "192.168.0.0/24"
      availability_zone = "${var.aws_region}a"
      name              = "Public A"
    },
    "pub_b" : {
      cidr_block        = "192.168.1.0/24"
      availability_zone = "${var.aws_region}b"
      name              = "Public B"
    },
    "priv_a" : {
      cidr_block        = "192.168.2.0/24"
      availability_zone = "${var.aws_region}a"
      name              = "Private A"
      }, "priv_b" : {
      cidr_block        = "192.168.3.0/24"
      availability_zone = "${var.aws_region}b"
      name              = "Private B"
    }
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags              = merge(var.common_tags, { Name = each.value.name })
}
