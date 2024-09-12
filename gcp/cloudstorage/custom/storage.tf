# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket

resource "google_storage_bucket" "default" {
    name = local.bucket_name
    location = var.REGION
    force_destroy = true
    storage_class = "STANDARD"
    labels = local.common_tags

    lifecycle_rule {
        action {
            type = "Delete"
        }

        condition {
            age = "5"
        }
    }

    versioning {
        enabled = false
    }

    soft_delete_policy {
        retention_duration_seconds = 0
    }

    encryption {
        default_kms_key_name = data.google_kms_crypto_key.default.id
    }

    depends_on = [ google_kms_crypto_key_iam_member.encrypter_decrypter_binding ]
}

resource "google_storage_bucket_object" "site" {
    name = "site.html"
    bucket = google_storage_bucket.default.name
    source = "./assets/site.html"
}