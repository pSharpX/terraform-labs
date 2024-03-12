resource "aws_iam_user_policy_attachment" "s3-policy-attachment" {
    user = "s3-user-1"
    policy_arn = data.aws_iam_policy.s3_readonlyaccess_policy.arn
    depends_on = [ aws_iam_user.s3-users ]
}

resource "aws_iam_user_policy_attachment" "iam-policy-attachment" {
    user = "iam-user-2"
    policy_arn = data.aws_iam_policy.iam_readonlyaccess_policy.arn
    depends_on = [ aws_iam_user.s3-users ]
}

resource "aws_iam_user_policy_attachment" "ec2-policy-attachment" {
    user = "ec2-user-3"
    policy_arn = data.aws_iam_policy.ec2_readonlyaccess_policy.arn
    depends_on = [ aws_iam_user.s3-users ]
}