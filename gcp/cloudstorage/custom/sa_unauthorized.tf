# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam
# https://cloud.google.com/storage/docs/access-control/iam-roles

resource "google_service_account" "unauthorized_sa" {
    project = data.google_project.onebank.project_id
    account_id = "${local.applicationId}-gcs-unauthorized-sa"
    display_name = "Service Account for OneBank Cloud Storage Buckets"
    description = "Service Account for Cloud Storage Buckets"
}

# Roles
# roles/storage.objectViewer
# roles/storage.objectCreator
# roles/storage.objectUser
# roles/storage.objectAdmin
# roles/storage.folderAdmin
# roles/storage.admin

resource "google_service_account_key" "unauthorized_key" {
    service_account_id = google_service_account.unauthorized_sa.name
}

resource "local_file" "unauthorized_account_credentials" {
    content = base64decode(google_service_account_key.unauthorized_key.private_key)
    filename = "./configs/onebank-gcs-unauthorized-sa.json"
}

data "google_service_account_access_token" "unauthorized_access_token" {
    target_service_account = google_service_account.unauthorized_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}