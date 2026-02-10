
output "state_bucket_arn" {
  value = aws_s3_bucket.state.arn
}

output "state_bucket_domain_name" {
  value = aws_s3_bucket.state.bucket_domain_name
}

output "state_table_arn" {
  value = aws_dynamodb_table.lock.arn
}