resource "aws_security_group" "web" {
  name        = "web"
  description = "Allows public inbound traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 80 # http
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.this["priv_a"].cidr_block]
  }

  tags = merge(var.common_tags, { Name = format("%s-web-server-sg", var.common_tags.service_name) })
}

resource "aws_security_group" "db" {
  name        = "DB"
  description = "Allows incoming database connections"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port       = 3306 # mysql
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = format("%s-mysql-db-sg", var.common_tags.service_name) })
}

resource "aws_security_group" "alb" {
  name        = "ALB"
  description = "Load Balancer SG"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 80 # http
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = format("%s-load-balancer-sg", var.common_tags.service_name) })
}
