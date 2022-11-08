resource "aws_instance" "kibana_server" {
  ami = data.aws_ami.kibana_on_ubuntu.id
  instance_type = "t3.medium"
  subnet_id = data.aws_subnet.public_subnet.id
user_data = templatefile("${path.module}/user-data.sh.tpl",
  {
    elasticsearch_ip = aws_instance.elasticSearch_ec2.private_ip
  })
  ebs_block_device  {
    device_name = "/dev/xvdba"
    volume_size = "50"
    }
  vpc_security_group_ids = [aws_security_group.kibana_sg.id]
  iam_instance_profile = aws_iam_instance_profile.elk_instance_profile.name
  tags = {
    Name = "kibana_server"
  }
}
resource "aws_security_group" "kibana_sg" {
  name        = "kibana_sg"
  description = "Allows Access to Kibana"
  vpc_id      = data.aws_vpc.elk_vpc.id

  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 5601
    to_port = 5601
    protocol = "tcp"
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "kibana_sg"
  }
}