
resource "aws_iam_policy" "dynamodb_table_policy" {
    name = "onebank-dynamodb-read-put-policy"
    description = "Allow GetItem, PutItem, Scan and Query on a single Dynamodb table"
    policy = data.aws_iam_policy_document.dynamodb_read_put_policy.json
    tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "onebank_user_policy_attachment" {
    role = aws_iam_role.ecs_task_role.name
    policy_arn = aws_iam_policy.dynamodb_table_policy.arn
}