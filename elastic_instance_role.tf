resource "aws_iam_instance_profile" "elastic_instance_profile" {
  name = "elastic_instance_profile"
  role = aws_iam_role.elastic_role.name
}


resource "aws_iam_role" "elastic_role" {
  name = "elastic_role"

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

resource "aws_iam_role_policy_attachment" "elastic_attach" {
  role       = aws_iam_role.elastic_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

