data "aws_vpc" "default_vpc" {
    default = true
}

data "aws_subnet" "default_subnet" {
    vpc_id = data.aws_vpc.default_vpc.id
    availability_zone = "us-east-1a"
    default_for_az = true
}

data "aws_iam_policy_document" "dynamodb_read_put_policy" {
    version = "2012-10-17"

    statement {
        sid = "ReadPutItems"
        effect = "Allow"
        actions = [
            "dynamodb:GetItem",
            "dynamodb:PutItem",
            "dynamodb:UpdateItem",
            "dynamodb:DeleteItem",
            "dynamodb:Query",
            "dynamodb:Scan"
        ]
        resources = [ "*" ]
        /*resources = [
            "${aws_dynamodb_table.onebank_notification_table.arn}",
            "${aws_dynamodb_table.onebank_notification_table.arn}/index/*"
        ]*/
    }
}