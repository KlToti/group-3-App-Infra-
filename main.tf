data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = [var.ubuntu_version]
  }
  owners = [var.ami_owner] # Canonical
}

data "aws_ami" "kibana_on_ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = [var.kibana_ubuntu_version]
  }
  owners = [var.kibana_ami_owner] # Canonical
}

#data "amazon-ami" "ubuntu" {
#        filters = {
#            name = var.source_ami_name
#            }
#        owners = [var.ami_owner]
#        most_recent = true
#    }

# data "aws_iam_instance_profile" "ssm_instance_profile" {
#     name = "ssm_instance_profile"
# }