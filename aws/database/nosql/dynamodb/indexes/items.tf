
resource "aws_dynamodb_table_item" "notification_default_item" {
    table_name = aws_dynamodb_table.onebank_notification_table.name
    hash_key = aws_dynamodb_table.onebank_notification_table.hash_key
    range_key = aws_dynamodb_table.onebank_notification_table.range_key
    
    item = <<ITEM
{
    "pk": { "S": "USER#100" },
    "sk": { "S": "NOTIF#2025-01-20T10:15:00Z#100" },
    "notification_id": { "S": "100" },
    "type": { "S": "PAYMENT_FAILED" },
    "title": { "S": "Payment failed" },
    "message": { "S": "Your payment for invoice #998 failed." },
    "metadata": { "B": "${local.metadata}" },
    "is_read": { "S": "false" },
    "created_at": { "S": "2025-01-20T10:15:00Z" }
}
ITEM

}