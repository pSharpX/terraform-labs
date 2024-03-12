data "aws_iam_policy" "s3_readonlyaccess_policy" {
    name = "AmazonS3ReadOnlyAccess"
}

data "aws_iam_policy" "iam_readonlyaccess_policy" {
    name = "IAMReadOnlyAccess"
}

data "aws_iam_policy" "ec2_readonlyaccess_policy" {
    name = "AmazonEC2ReadOnlyAccess"
}
