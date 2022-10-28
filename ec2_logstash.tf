resource "aws_security_group" "logstash_sg" {
  name        = "logstash_sg"
  description = "Allows beat port and web api calls"
  vpc_id      = data.aws_vpc.elk_vpc.id

  ingress {
    description      = "for access of Beats"
    from_port        = 5033 #difference from 5044
    to_port          = 5033
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
    instance_type = "t3.micro"
    subnet_id = data.aws_subnet.private_subnet.id
    ebs_block_device  {
        device_name = "logstash-ebs"
        volume_size = "50"
    }
    security_groups = [aws_security_group.logstash_sg.id]
#    iam_instance_profile = data.aws_iam_instance_profile.ssm_instance_profile.name
}



