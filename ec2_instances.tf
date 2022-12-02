resource "aws_instance" "elasticSearch_ec2" {
  ami           = data.aws_ami.ubuntu.id
  key_name      = "group3-ec2"
  instance_type = "t3.medium"
  subnet_id     = data.aws_subnet.private_subnet.id
  root_block_device {
    volume_size = "50"
  }
  vpc_security_group_ids = [aws_security_group.elasticSearch_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.elk_instance_profile.name
  tags = {
    Name    = "elasticSearch_server"
    Project = "ELK-final-project"
  }
}

resource "aws_instance" "logstash_ec2" {
  ami           = data.aws_ami.ubuntu.id
  key_name      = "group3-ec2"
  instance_type = "t3.medium"
  subnet_id     = data.aws_subnet.private_subnet.id
  root_block_device {
    volume_size = "50"
  }
  vpc_security_group_ids = [aws_security_group.logstash_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.elk_instance_profile.name
  tags = {
    Name    = "logstash_server"
    Project = "ELK-final-project"
  }
}

resource "aws_instance" "kibana_ec2" {
  ami           = data.aws_ami.kibana_on_ubuntu.id
  instance_type = "t3.medium"
  subnet_id     = data.aws_subnet.public_subnet.id
  root_block_device {
    volume_size = "50"
  }
  user_data = templatefile("${path.module}/user_data/kibana_user_data.sh.tpl",
    {
      elasticsearch_ip = aws_instance.elasticSearch_ec2.private_ip
  })
  vpc_security_group_ids = [aws_security_group.kibana_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.elk_instance_profile.name
  tags = {
    Name    = "kibana_server"
    Project = "ELK-final-project"
  }
}




