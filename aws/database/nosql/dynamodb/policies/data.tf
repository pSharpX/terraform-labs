data "aws_iam_policy_document" "dynamodb_read_put_policy" {
    version = "2012-10-17"

    statement {
        sid = "ReadPutItems"
        effect = "Allow"
        actions = [
            "dynamodb:GetItem",
            "dynamodb:PutItem",
            "dynamodb:Query",
            "dynamodb:Scan"
        ]
        resources = [
            "${aws_dynamodb_table.onebank_notification_table.arn}",
            "${aws_dynamodb_table.onebank_notification_table.arn}/index/*"
        ]
    }
}

data "aws_iam_group" "onebank_group" {
    group_name = "contractors"
}
