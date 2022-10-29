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
  role       = aws_iam_role.elk_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

