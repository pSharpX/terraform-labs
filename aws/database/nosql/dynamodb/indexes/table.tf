
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

    attribute {
        name = "notification_id"
        type = "S" 
    }

    attribute {
        name = "type"
        type = "S" 
    }

    attribute {
        name = "title"
        type = "S" 
    }

    attribute {
        name = "message"
        type = "S" 
    }

    attribute {
        name = "metadata"
        type = "B" 
    }

    attribute {
        name = "is_read"
        type = "S" 
    }

    attribute {
        name = "created_at"
        type = "S" 
    }

    global_secondary_index {
        name = "notification_type_index"
        projection_type = "ALL"
        hash_key = "type"
        range_key = "pk"
    }

    global_secondary_index {
        name = "notification_id_index"
        projection_type = "ALL"
        hash_key = "notification_id"
        range_key = "pk"
    }

    local_secondary_index {
        name = "is_read_index"
        projection_type = "ALL"
        range_key = "is_read"
    }

    local_secondary_index {
        name = "created_at_index"
        projection_type = "ALL"
        range_key = "created_at"
    }

    local_secondary_index {
        name = "title_index"
        projection_type = "ALL"
        range_key = "title"
    }

    local_secondary_index {
        name = "message_index"
        projection_type = "ALL"
        range_key = "message"
    }

    local_secondary_index {
        name = "metadata_index"
        projection_type = "ALL"
        range_key = "metadata"
    }

    ttl {
        attribute_name = "ttl"
        enabled = true
    }
}