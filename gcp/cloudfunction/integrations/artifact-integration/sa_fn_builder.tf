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

resource "google_artifact_registry_repository_iam_member" "artifact_registry_writer_permission" {
    project = data.google_project.onebank.project_id
    repository = data.google_artifact_registry_repository.onebank_repository.id
    role = "roles/artifactregistry.writer"
    member = "serviceAccount:${google_service_account.builder_sa.email}"
}

# builder permissions need to stablize before it can pull the source zip
resource "time_sleep" "wait_60s" {
  create_duration = "60s"

  depends_on = [
    google_artifact_registry_repository_iam_member.artifact_registry_writer_permission,
    google_project_iam_member.storage_object_viewer_permission,
    google_project_iam_member.storage_object_admin_permission
  ]
}
