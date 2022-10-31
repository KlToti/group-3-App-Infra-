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
    instance_type = "t3.medium"
    subnet_id = data.aws_subnet.private_subnet.id
    ebs_block_device  {
        device_name = "/dev/xvdba"
        volume_size = "50"
    }
    security_groups = [aws_security_group.logstash_sg.id]
    iam_instance_profile = "${aws_iam_instance_profile.elk_instance_profile.name}"
    #user_data = filebase64("${path.module}/ssm-agent-install.sh")
}


resource "aws_iam_instance_profile" "elk_instance_profile" {
  name = "elk_instance_profile"
  role = aws_iam_role.elk_role.name
}


resource "aws_iam_role" "elk_role" {
  name = "elk_role"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": {"Service": "ssm.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }
  }
EOF
}


resource "aws_iam_role_policy_attachment" "elk_attach" {
    for_each = toset([
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
  ])

  role       = aws_iam_role.elk_role.name
  policy_arn = each.value
}