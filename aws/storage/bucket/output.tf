output "bucket-id" {
  value = aws_s3_bucket.onebank-storage.id
}

output "bucket-hostname" {
  value = aws_s3_bucket.onebank-storage.bucket_domain_name
}