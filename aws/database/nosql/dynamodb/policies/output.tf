output "notification_table_arn" {
    value = aws_dynamodb_table.onebank_notification_table.arn
}

output "notification_dlq_table_arn" {
    value = aws_dynamodb_table.onebank_notification_dlq_table.arn
}

output "onebank_user" {
    value = aws_iam_user.onebank_user.arn
}

output "onebank_user_credential_id" {
    value = aws_iam_access_key.onebank_user_access_key.id
}

output "onebank_user_credential_secret" {
    sensitive = true
    value = aws_iam_access_key.onebank_user_access_key.secret
}

output "onebank_user_login_profile" {
    sensitive = true
    value = aws_iam_user_login_profile.onebank_user_login_profile.password
}