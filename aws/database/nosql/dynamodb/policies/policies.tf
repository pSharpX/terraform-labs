
resource "aws_iam_policy" "dynamodb_table_policy" {
    name = "${local.table_name}-dynamodb-read-put-policy"
    description = "Allow GetItem, PutItem, Scan and Query on a single Dynamodb table"
    policy = data.aws_iam_policy_document.dynamodb_read_put_policy.json
    tags = local.common_tags
}

resource "aws_iam_user_policy_attachment" "onebank_user_policy_attachment" {
    user = aws_iam_user.onebank_user.name
    policy_arn = aws_iam_policy.dynamodb_table_policy.arn
}