resource "aws_instance" "elasticSearch_ec2" {
    ami = data.aws_ami.ubuntu.id
    #instance type valued as specified in the ticket
    instance_type = "t3.medium"
    subnet_id = data.aws_subnet.private_subnet.id
    ebs_block_device  {
        device_name = "/dev/xvdba"
        volume_size = "50"
    }
    vpc_security_group_ids = [aws_security_group.elasticSearch_sg.id]
    iam_instance_profile = aws_iam_instance_profile.elk_instance_profile.name
    tags = {
      Name = "elasticSearch_server"
  }
}
resource "aws_security_group" "elasticSearch_sg" {
  name        = "ElasticSearch_sg"
  description = "Allows logstash port"
  vpc_id      = data.aws_vpc.elk_vpc.id

  ingress {
    description = "ingress rules"
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 22
    protocol = "tcp"
    to_port = 22
  }
  ingress {
    description = "ingress rules"
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 9200
    protocol = "tcp"
    to_port = 9300
  } 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "elasticSearch_sg"
  }
}



