# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam
# https://cloud.google.com/storage/docs/access-control/iam-roles

resource "google_service_account" "default" {
    project = data.google_project.onebank.project_id
    account_id = "${local.applicationId}-gcs-viewer-sa"
    display_name = "Object Viewer Service Account"
    description = "Service Account with Cloud Storage Object Viewer Permission"
}

# Roles
# roles/storage.objectViewer
# roles/storage.objectCreator
# roles/storage.objectUser
# roles/storage.objectAdmin
# roles/storage.folderAdmin
# roles/storage.admin

resource "google_storage_bucket_iam_member" "bucket_object_viewer_role" {
    bucket = google_storage_bucket.default.name
    role = "roles/storage.objectViewer"
    member = "serviceAccount:${google_service_account.default.email}"
}

data "google_service_account_access_token" "default_access_token" {
    target_service_account = google_service_account.default.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]

    depends_on = [ google_storage_bucket_iam_member.bucket_object_viewer_role ]
}