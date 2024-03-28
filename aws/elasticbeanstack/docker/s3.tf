resource "aws_s3_bucket" "onebank_application_storage" {
    bucket = local.application_assets
    tags = local.assets_tags
}

resource "aws_s3_object" "application_assets" {
    bucket = aws_s3_bucket.onebank_application_storage.id
    key = "Dockerrun.aws.json"
    source = "./config/Dockerrun.aws.json"
    etag = filemd5("./config/Dockerrun.aws.json")
    tags = local.common_tags
}

