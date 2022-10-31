data "aws_vpc" "elk_vpc" {
  filter {
    name = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "public_subnet" {
  filter {
    name = "tag:Name"
    values = [var.public_subnet_name]
  }
}

data "aws_subnet" "private_subnet" {
  filter {
    name = "tag:Name"
    values = [var.private_subnet_name]
  }
}
