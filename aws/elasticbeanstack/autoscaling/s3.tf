resource "aws_s3_bucket" "onebank_application_storage" {
    bucket = local.application_assets
    tags = local.assets_tags
}

resource "aws_s3_object" "application_assets" {
    bucket = aws_s3_bucket.onebank_application_storage.id
    key = "${sha256(local_file.docker_manifest.content)}.zip"
    source = data.archive_file.docker_run.output_path
    tags = local.common_tags

    depends_on = [ local_file.docker_manifest, data.archive_file.docker_run ]
}
