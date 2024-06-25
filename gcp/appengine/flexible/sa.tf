resource "google_service_account" "taskmaster_sa" {
    project = data.google_project.onebank.project_id
    account_id = "taskmaster-sa"
    display_name = "taskmaster-sa"
    description = "Service Account for Task Master application"
}

resource "google_project_iam_member" "gae_api" {
    project = data.google_project.onebank.project_id
    role = "roles/compute.networkUser"
    member = "serviceAccount:${google_service_account.taskmaster_sa.email}"
}

resource "google_project_iam_member" "logs_writer" {
    project = data.google_project.onebank.project_id
    role = "roles/logging.logWriter"
    member = "serviceAccount:${google_service_account.taskmaster_sa.email}"
}

resource "google_project_iam_member" "storage_viewer" {
    project = data.google_project.onebank.project_id
    role = "roles/storage.objectViewer"
    member = "serviceAccount:${google_service_account.taskmaster_sa.email}"
}

resource "google_project_iam_member" "registry_reader" {
    project = data.google_project.onebank.project_id
    role = "roles/artifactregistry.reader"
    member = "serviceAccount:${google_service_account.taskmaster_sa.email}"
}

resource "google_service_account_key" "taskmaster_key" {
    service_account_id = google_service_account.taskmaster_sa.name
}

resource "local_file" "account_credentials" {
    content = base64decode(google_service_account_key.taskmaster_key.private_key)
    filename = "./configs/taskmaster-sa.json"
}