resource "google_service_account" "default" {
    project = data.google_project.onebank.project_id
    account_id = "${local.control_plane}-sa"
    display_name = "Service Account for OneBank Control Plane application"
    description = "Service Account for application running in Cloud Run"
}

resource "google_service_account" "client_app" {
    project = data.google_project.onebank.project_id
    account_id = "${local.control_plane}-client-sa"
    display_name = "Service Account for Application Client or Consumer"
    description = "Service Account for VM being able to consume/invoke Cloud Run application"
}

# Roles
# roles/run.invoker

resource "google_cloud_run_v2_service_iam_member" "invoker_permission" {
    location = google_cloud_run_v2_service.onebank_app.location
    name = google_cloud_run_v2_service.onebank_app.name
    role = "roles/run.invoker"
    member = "serviceAccount:${google_service_account.client_app.email}"
}

resource "google_service_account_key" "default_sa_key" {
    service_account_id = google_service_account.default.name
}

resource "local_file" "default_account_credentials" {
    content = base64decode(google_service_account_key.default_sa_key.private_key)
    filename = "./configs/${local.control_plane}-sa.json"
}

data "google_service_account_access_token" "default_sa_access_token" {
    target_service_account = google_service_account.default.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}

data "google_service_account_access_token" "client_sa_access_token" {
    target_service_account = google_service_account.client_app.email
    lifetime = "3600s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}
