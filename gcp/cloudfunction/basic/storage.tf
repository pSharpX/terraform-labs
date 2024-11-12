# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket

resource "google_storage_bucket" "default" {
    name = local.bucket_name
    location = var.REGION
    force_destroy = true
    storage_class = "STANDARD"
    labels = local.common_tags
}

resource "google_storage_bucket_object" "source" {
    name = local.bucket_object_name
    bucket = google_storage_bucket.default.name
    source = var.SOURCE_PATH
}
