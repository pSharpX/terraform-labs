# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function_iam
# https://cloud.google.com/functions/docs/reference/iam/roles

resource "google_service_account" "builder_sa" {
    project = data.google_project.onebank.project_id
    account_id = "${local.applicationId}-fn-builder-sa"
    display_name = "Onebank Functions Builder Config Account"
    description = "Service Account with required permissions for Onebank Functions during Build Phase"
}

# Roles
# roles/storage.objectAdmin
# roles/storage.objectViewer
# roles/artifactregistry.writer

resource "google_project_iam_member" "storage_object_admin_permission" {
    project = data.google_project.onebank.project_id
    role = "roles/storage.objectAdmin"
    member = "serviceAccount:${google_service_account.builder_sa.email}"
}

resource "google_project_iam_member" "storage_object_viewer_permission" {
    project = data.google_project.onebank.project_id
    role = "roles/storage.objectViewer"
    member = "serviceAccount:${google_service_account.builder_sa.email}"
}

resource "google_project_iam_member" "artifact_registry_writer_permission" {
    project = data.google_project.onebank.project_id
    role = "roles/artifactregistry.writer"
    member = "serviceAccount:${google_service_account.builder_sa.email}"
}

resource "google_service_account_key" "builder_key" {
    service_account_id = google_service_account.builder_sa.name
}

resource "local_file" "builder_account_credentials" {
    content = base64decode(google_service_account_key.builder_key.private_key)
    filename = "./configs/onebank-fn-builder-sa.json"
}

data "google_service_account_access_token" "builder_access_token" {
    target_service_account = google_service_account.builder_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}