resource "aws_security_group" "logstash_sg" {
  name        = "logstash_sg"
  description = "Allows beat port and web api calls"
  vpc_id      = data.aws_vpc.elk_vpc.id

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "for access of Beats"
    from_port        = 5044                     #changed from 5033 discrepancy in Trello cards
    to_port          = 5044
    protocol         = "tcp"
    cidr_blocks      = [data.aws_subnet.private_subnet.cidr_block]
  }

    ingress {
    description      = "for access of Web API calls"
    from_port        = 9600
    to_port          = 9700
    protocol         = "tcp"
    cidr_blocks      = [data.aws_subnet.private_subnet.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "logstash_sg"
  }
}


resource "aws_instance" "logstash_ec2" {
    ami = data.aws_ami.ubuntu.id
    key_name = "group3-ec2"
    instance_type = "t3.medium"
    subnet_id = data.aws_subnet.private_subnet.id
    root_block_device  {
        volume_size = "50"
    }
    vpc_security_group_ids = [aws_security_group.logstash_sg.id]
    iam_instance_profile = aws_iam_instance_profile.elk_instance_profile.name

    tags = {
    Name = "logstash_server"
  }
}