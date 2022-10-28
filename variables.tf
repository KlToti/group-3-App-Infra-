variable "vpc_name" {
    description = "tag Name of created VPC in group-3-Network"
    type = string
}

variable "public_subnet_name" {
    description = "tag Name of created public subnet in group-3-Network"
    type = string
}

variable "private_subnet_name" {
    description = "tag Name of created private subnet in group-3-Network"
    type = string
}

variable "ubuntu_version" {
    description = "version of ubuntu"
    type = string
}

variable "ami_owner" {
    description = "ID of AMI owner"
    type = string
}