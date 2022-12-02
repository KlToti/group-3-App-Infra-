resource "aws_security_group" "elasticSearch_sg" {
  name        = "ElasticSearch_sg"
  description = "Allows logstash port"
  vpc_id      = data.aws_vpc.elk_vpc.id

  ingress {
    description = "ingress rules"
    from_port   = 9200
    to_port     = 9300
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "elasticSearch_sg"
    Project = "ELK-final-project"
  }
}

resource "aws_security_group" "logstash_sg" {
  name        = "logstash_sg"
  description = "Allows beat port and web api calls"
  vpc_id      = data.aws_vpc.elk_vpc.id

  ingress {
    description = "for access of Beats"
    from_port   = 5044
    to_port     = 5044
    protocol    = "tcp"
    cidr_blocks = [data.aws_subnet.private_subnet.cidr_block]
  }
  ingress {
    description = "for access of Web API calls"
    from_port   = 9600
    to_port     = 9700
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
    Name    = "logstash_sg"
    Project = "ELK-final-project"
  }
}

resource "aws_security_group" "kibana_sg" {
  name        = "kibana_sg"
  description = "Allows Access to Kibana"
  vpc_id      = data.aws_vpc.elk_vpc.id
  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "kibana_sg"
    Project = "ELK-final-project"
  }
}



