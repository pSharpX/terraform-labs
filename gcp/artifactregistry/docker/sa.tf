resource "google_service_account" "global_artifact_sa" {
    project = data.google_project.onebank.project_id
    account_id = "global-artifact-sa"
    display_name = "Global Artifact Service Account"
    description = "Global Service Account for Artifact Registries"
}

resource "google_service_account" "repository_specific_sa" {
    project = data.google_project.onebank.project_id
    account_id = "repository-specific-sa"
    display_name = "Repository Service Account"
    description = "Service Account for Artifact Registry with Repository-specific permissions"
}

resource "google_project_iam_member" "artifact_reader" {
    project = data.google_project.onebank.project_id
    role = "roles/artifactregistry.reader"
    member = "serviceAccount:${google_service_account.global_artifact_sa.email}"
}

resource "google_project_iam_member" "artifact_writer" {
    project = data.google_project.onebank.project_id
    role = "roles/artifactregistry.writer"
    member = "serviceAccount:${google_service_account.global_artifact_sa.email}"
}

resource "google_artifact_registry_repository_iam_member" "repository_reader" {
    project = data.google_project.onebank.project_id
    location = google_artifact_registry_repository.onebank_repository.location
    repository = google_artifact_registry_repository.onebank_repository.name
    role = "roles/artifactregistry.reader"
    member = "serviceAccount:${google_service_account.repository_specific_sa.email}"

    depends_on = [ google_artifact_registry_repository.onebank_repository ]
}

resource "google_artifact_registry_repository_iam_member" "repository_writer" {
    project = data.google_project.onebank.project_id
    location = google_artifact_registry_repository.onebank_repository.location
    repository = google_artifact_registry_repository.onebank_repository.name
    role = "roles/artifactregistry.writer"
    member = "serviceAccount:${google_service_account.repository_specific_sa.email}"

    depends_on = [ google_artifact_registry_repository.onebank_repository ]
}

resource "google_service_account_key" "global_artifact_key" {
    service_account_id = google_service_account.global_artifact_sa.name
}

resource "google_service_account_key" "repository_specific_key" {
    service_account_id = google_service_account.repository_specific_sa.name
}

resource "local_file" "global_account_credentials" {
    content = base64decode(google_service_account_key.global_artifact_key.private_key)
    filename = "./configs/global-artifact-sa.json"
}

resource "local_file" "account_credentials" {
    content = base64decode(google_service_account_key.repository_specific_key.private_key)
    filename = "./configs/repository-specific-sa.json"
}

data "google_service_account_access_token" "global" {
    target_service_account = google_service_account.global_artifact_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}

data "google_service_account_access_token" "repository_specific" {
    target_service_account = google_service_account.repository_specific_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}