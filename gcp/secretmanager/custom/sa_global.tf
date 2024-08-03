# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_iam

resource "google_service_account" "global_secret_sa" {
    project = data.google_project.onebank.project_id
    account_id = "global-secret-sa"
    display_name = "Global Secret Service Account"
    description = "Global Service Account for Cloud Secret Manager"
}

# Roles
# roles/secretmanager.admin
# roles/secretmanager.secretAccessor
# roles/secretmanager.secretVersionManager
# roles/secretmanager.viewer
# roles/secretmanager.secretVersionAdder

resource "google_project_iam_member" "secret_accessor" {
    project = data.google_project.onebank.project_id
    role = "roles/secretmanager.secretAccessor"
    member = "serviceAccount:${google_service_account.global_secret_sa.email}"
}

resource "google_service_account_key" "global_secret_sa_key" {
    service_account_id = google_service_account.global_secret_sa.name
}

resource "local_file" "global_account_credentials" {
    content = base64decode(google_service_account_key.global_secret_sa_key.private_key)
    filename = "./configs/global-secret-sa.json"
}

data "google_service_account_access_token" "global_sa_access_token" {
    target_service_account = google_service_account.global_secret_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}
