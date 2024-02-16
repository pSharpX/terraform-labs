resource "aws_s3_bucket" "onebank-storage" {
    bucket = local.bucket_name
    tags = local.common_tags
}