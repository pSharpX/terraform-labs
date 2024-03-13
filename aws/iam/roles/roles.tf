resource "aws_iam_role" "onebank-developer-role" {
    name = "onebank-developer-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid = ""
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })

    tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "developer-role-policy-attachment" {
    role = aws_iam_role.onebank-developer-role.name
    policy_arn = aws_iam_policy.onebank-s3-policy.arn
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

resource "aws_iam_role" "onebank-administrator-role" {
    name = "onebank-administrator-role"
    assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
    tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "administrator-role-policy-attachment" {
    role = aws_iam_role.onebank-administrator-role.name
    policy_arn = aws_iam_policy.onebank-s3-policy.arn
}

resource "aws_iam_role" "onebank-contractor-role" {
    name = "onebank-contractor-role"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
    tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "contractor-role-policy-attachment" {
    role = aws_iam_role.onebank-contractor-role.name
    policy_arn = aws_iam_policy.onebank-s3-policy.arn
}