data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = [var.ubuntu_version]
  }
  owners = [var.ami_owner] # Canonical
}

data "aws_ami" "kibana_on_ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = [var.kibana_ubuntu_version]
  }
  owners = [var.kibana_ami_owner] # Canonical
}

data "aws_vpc" "elk_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "public_subnet" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_name]
  }
}

data "aws_subnet" "private_subnet" {
  filter {
    name   = "tag:Name"
    values = [var.private_subnet_name]
  }
}