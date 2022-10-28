resource "aws_iam_instance_profile" "logstash_instance_profile" {
  name = "logs_profile"
  role = aws_iam_role.logs_role.name
}


resource "aws_iam_role" "logs_role" {
  name = "logs_role"

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

resource "aws_iam_role_policy_attachment" "logs_attach" {
  role       = aws_iam_role.logs_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

