resource "google_service_account" "default" {
    project = data.google_project.onebank.project_id
    account_id = "${local.control_plane}-sa"
    display_name = "Service Account for OneBank Control Plane application"
    description = "Service Account for application running in Cloud Run"
}

# Roles
# roles/storage.objectViewer

resource "google_storage_bucket_iam_member" "configs_object_viewer_role" {
    bucket = google_storage_bucket.configs.name
    role = "roles/storage.objectViewer"
    member = "serviceAccount:${google_service_account.default.email}"
}

resource "google_storage_bucket_iam_member" "assets_object_viewer_role" {
    bucket = google_storage_bucket.assets.name
    role = "roles/storage.objectViewer"
    member = "serviceAccount:${google_service_account.default.email}"
}

resource "google_service_account_key" "default_sa_key" {
    service_account_id = google_service_account.default.name
}

resource "local_sensitive_file" "default_account_credentials" {
    content = base64decode(google_service_account_key.default_sa_key.private_key)
    filename = "./configs/${local.control_plane}-sa.json"
}

data "google_service_account_access_token" "default_sa_access_token" {
    target_service_account = google_service_account.default.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}
