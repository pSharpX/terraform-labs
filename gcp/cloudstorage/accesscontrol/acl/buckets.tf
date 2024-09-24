# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket

resource "google_storage_bucket" "assets" {
    name = "${local.bucket_name}-assets"
    location = var.REGION
    force_destroy = true
    storage_class = "STANDARD"
    labels = local.common_tags

    # Error 412: The member bindings allUsers and allAuthenticatedUsers are not allowed since public access prevention is enforced., conditionNotMet
    public_access_prevention = "inherited"
}

resource "google_storage_bucket" "web" {
    name = "${local.bucket_name}-web"
    location = var.REGION
    force_destroy = true
    storage_class = "STANDARD"
    labels = local.common_tags

    public_access_prevention = "inherited"
}