
resource "aws_dynamodb_table" "onebank_notification_table" {
    name = local.table_name
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "pk"
    range_key = "sk"
    deletion_protection_enabled = false
    tags = local.table_tags

    attribute {
        name = "pk"
        type = "S"
    }

    attribute {
        name = "sk"
        type = "S"
    }

    ttl {
        attribute_name = "ttl"
        enabled = true
    }
}