# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_iam

resource "google_service_account" "secret_specific_sa" {
    project = data.google_project.onebank.project_id
    account_id = "secret-specific-sa"
    display_name = "Secret-Specific Service Account"
    description = "Service Account for Cloud Secret Manager (Secret-Specific)"
}

# Roles
# roles/secretmanager.admin
# roles/secretmanager.secretAccessor
# roles/secretmanager.secretVersionManager
# roles/secretmanager.viewer
# roles/secretmanager.secretVersionAdder

resource "google_secret_manager_secret_iam_member" "secret_accessor" {
    project = data.google_project.onebank.project_id
    secret_id = google_secret_manager_secret.db_password.id
    role = "roles/secretmanager.secretAccessor"
    member = "serviceAccount:${google_service_account.secret_specific_sa.email}"
}

resource "google_service_account_key" "secret_specific_sa_key" {
    service_account_id = google_service_account.secret_specific_sa.name
}

resource "local_file" "secret_specific_account_credentials" {
    content = base64decode(google_service_account_key.secret_specific_sa_key.private_key)
    filename = "./configs/secret-specific-sa.json"
}

data "google_service_account_access_token" "secret_specific_sa_access_token" {
    target_service_account = google_service_account.secret_specific_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}
