# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam

resource "google_kms_crypto_key_iam_member" "encrypter_decrypter_binding" {
    crypto_key_id = data.google_kms_crypto_key.default.id
    role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
    member = "serviceAccount:${data.google_storage_project_service_account.gcs_acount.email_address}"
}

resource "google_service_account" "default" {
    project = data.google_project.onebank.project_id
    account_id = "${local.applicationId}-gcs-sa"
    display_name = "Service Account for OneBank Cloud Storage Buckets"
    description = "Service Account for Cloud Storage Buckets"
}

# Roles
# roles/storage.objectViewer

resource "google_storage_bucket_iam_member" "bucket_object_viewer_role" {
    bucket = google_storage_bucket.default.name
    role = "roles/storage.objectViewer"
    member = "serviceAccount:${google_service_account.default.email}"
}

resource "google_service_account_key" "default_key" {
    service_account_id = google_service_account.default.name
}

resource "local_file" "default_account_credentials" {
    content = base64decode(google_service_account_key.default_key.private_key)
    filename = "./configs/onebank-gcs-sa.json"
}

data "google_service_account_access_token" "default_access_token" {
    target_service_account = google_service_account.default.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}