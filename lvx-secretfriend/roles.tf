
resource "aws_iam_role" "application_role" {
  name = "${var.APPLICATION_ID}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "terraform_state_policy_attach" {
  role       = aws_iam_role.application_role.name
  policy_arn = aws_iam_policy.terraform_state_policy.arn
}