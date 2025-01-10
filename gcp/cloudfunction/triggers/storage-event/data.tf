data "google_project" "onebank" {
    project_id = var.PROJECT_ID
}

data "google_artifact_registry_repository" "onebank_repository" {
    location = var.REGION
    repository_id = var.REPOSITORY_ID
}

data "google_storage_project_service_account" "gcs_account" {
}