# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam
# https://cloud.google.com/storage/docs/access-control/iam-roles

resource "google_service_account" "user_sa" {
    project = data.google_project.onebank.project_id
    account_id = "${local.applicationId}-gcs-user-sa"
    display_name = "Object User Service Account"
    description = "Service Account with Cloud Storage Object User Permission"
}

# Roles
# roles/storage.objectViewer
# roles/storage.objectCreator
# roles/storage.objectUser
# roles/storage.objectAdmin
# roles/storage.folderAdmin
# roles/storage.admin

resource "google_storage_bucket_iam_member" "bucket_object_user_role" {
    bucket = google_storage_bucket.default.name
    role = "roles/storage.objectUser"
    member = "serviceAccount:${google_service_account.user_sa.email}"
}

resource "google_service_account_key" "user_key" {
    service_account_id = google_service_account.user_sa.name
}

resource "local_file" "user_account_credentials" {
    content = base64decode(google_service_account_key.user_key.private_key)
    filename = "./configs/onebank-gcs-user-sa.json"
}

data "google_service_account_access_token" "user_access_token" {
    target_service_account = google_service_account.user_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]

    depends_on = [ google_storage_bucket_iam_member.bucket_object_user_role ]
}