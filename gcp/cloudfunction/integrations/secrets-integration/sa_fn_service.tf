# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function_iam
# https://cloud.google.com/functions/docs/reference/iam/roles

resource "google_service_account" "service_sa" {
    project = data.google_project.onebank.project_id
    account_id = "${local.applicationId}-fn-service-sa"
    display_name = "Onebank Functions Service Account"
    description = "Service Account with required permissions for Onebank Functions"
}

# Roles
# roles/secretmanager.secretAccessor

resource "google_secret_manager_secret_iam_member" "cf_secrets_permission" {
    for_each = google_secret_manager_secret.cf_secrets
    project = data.google_project.onebank.project_id
    secret_id = google_secret_manager_secret.cf_secrets[each.key].id
    role = "roles/secretmanager.secretAccessor"
    member = "serviceAccount:${google_service_account.service_sa.email}"
}

resource "google_service_account_key" "service_key" {
    service_account_id = google_service_account.service_sa.name
}

resource "local_file" "service_account_credentials" {
    content = base64decode(google_service_account_key.service_key.private_key)
    filename = "./configs/onebank-fn-service-sa.json"
}

data "google_service_account_access_token" "service_access_token" {
    target_service_account = google_service_account.service_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}

resource "time_sleep" "wait_60s_for_service" {
  create_duration = "60s"

  depends_on = [
    google_secret_manager_secret_iam_member.cf_secrets_permission
  ]
}