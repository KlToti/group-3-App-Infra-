resource "aws_instance" "filebeat_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
  subnet_id     = data.aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.beats_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.elk_instance_profile.name
  user_data = templatefile("${path.module}/user-data-filebeat.sh.tpl",
    {
      LOGSTASH_IP = aws_instance.logstash_ec2.private_ip
  })
  tags = {
    Name    = "filebeat_server"
    Project = "ELK-final-project"
  }
}

resource "aws_instance" "metricbeat_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
  subnet_id     = data.aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.beats_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.elk_instance_profile.name
  user_data = templatefile("${path.module}/user-data-metricbeat.sh.tpl",
    {
      LOGSTASH_IP = aws_instance.logstash_ec2.private_ip
  })
  tags = {
    Name    = "metricbeat_server"
    Project = "ELK-final-project"
  }
}

resource "aws_security_group" "beats_sg" {
  name        = "beats_sg"
  description = "Allows beat port and web api calls"
  vpc_id      = data.aws_vpc.elk_vpc.id

  egress {
    description = "for sending to Logstash"
    from_port   = 5044
    to_port     = 5044
    protocol    = "tcp"
    cidr_blocks = [data.aws_subnet.private_subnet.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "beats_sg"
  }
}

