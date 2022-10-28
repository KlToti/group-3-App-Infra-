resource "aws_iam_instance_profile" "kibana_instance_profile" {
  name = "kibana_instance_profile"
  role = aws_iam_role.kibana_role.name
}


resource "aws_iam_role" "kibana_role" {
  name = "kibana_role"

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

resource "aws_iam_role_policy_attachment" "kibana_attach" {
  role       = aws_iam_role.kibana_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

