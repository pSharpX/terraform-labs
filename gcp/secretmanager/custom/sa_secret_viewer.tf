# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_iam
# https://gcp.permissions.cloud/iam/secretmanager#secretmanager.secrets.create

resource "google_service_account" "secret_viewer_sa" {
    project = data.google_project.onebank.project_id
    account_id = "secret-viewer-sa"
    display_name = "Viewer Secret-Specific Service Account"
    description = "Service Account for Cloud Secret Manager (Viewer Secret-Specific)"
}

# Roles
# roles/secretmanager.admin
# roles/secretmanager.secretAccessor
# roles/secretmanager.secretVersionManager
# roles/secretmanager.viewer
# roles/secretmanager.secretVersionAdder

resource "google_secret_manager_secret_iam_member" "secret_viewer" {
    project = data.google_project.onebank.project_id
    secret_id = google_secret_manager_secret.db_password.id
    role = "roles/secretmanager.viewer"
    member = "serviceAccount:${google_service_account.secret_viewer_sa.email}"
}

resource "google_service_account_key" "secret_viewer_sa_key" {
    service_account_id = google_service_account.secret_viewer_sa.name
}

resource "local_file" "secret_viewer_account_credentials" {
    content = base64decode(google_service_account_key.secret_viewer_sa_key.private_key)
    filename = "./configs/secret-viewer-sa.json"
}

data "google_service_account_access_token" "secret_viewer_sa_access_token" {
    target_service_account = google_service_account.secret_viewer_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}
