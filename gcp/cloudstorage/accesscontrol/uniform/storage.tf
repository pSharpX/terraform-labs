# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
# https://cloud.google.com/storage/docs/access-control
# https://cloud.google.com/storage/docs/uniform-bucket-level-access

resource "google_storage_bucket" "default" {
    name = local.bucket_name
    location = var.REGION
    force_destroy = true
    storage_class = "STANDARD"
    labels = local.common_tags

    uniform_bucket_level_access = true
    public_access_prevention = "enforced"
}

resource "google_storage_bucket_object" "site" {
    name = "site.html"
    bucket = google_storage_bucket.default.name
    source = "./assets/site.html"
}