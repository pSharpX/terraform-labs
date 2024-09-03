resource "google_service_account" "default" {
    project = data.google_project.onebank.project_id
    account_id = "${local.control_plane}-sa"
    display_name = "Service Account for OneBank Control Plane application"
    description = "Service Account for application running in Cloud Run"
}

# Roles
# roles/secretmanager.secretAccessor
# roles/cloudsql.client
# roles/cloudsql.instanceUser

resource "google_secret_manager_secret_iam_member" "datasource_url_secret_permission" {
    project = data.google_project.onebank.project_id
    secret_id = google_secret_manager_secret.datasource_url.id
    role = "roles/secretmanager.secretAccessor"
    member = "serviceAccount:${google_service_account.default.email}"
}

resource "google_project_iam_member" "sql_client_role" {
    project = data.google_project.onebank.project_id
    role = "roles/cloudsql.client"
    member = "serviceAccount:${google_service_account.default.email}"
}

resource "google_project_iam_member" "sql_instance_user_role" {
    project = data.google_project.onebank.project_id
    role = "roles/cloudsql.instanceUser"
    member = "serviceAccount:${google_service_account.default.email}"
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
