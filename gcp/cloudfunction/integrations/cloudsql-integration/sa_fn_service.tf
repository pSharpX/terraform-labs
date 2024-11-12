# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function_iam
# https://cloud.google.com/functions/docs/reference/iam/roles

resource "google_service_account" "service_sa" {
    project = data.google_project.onebank.project_id
    account_id = "${local.applicationId}-fn-service-sa"
    display_name = "Onebank Functions Service Account"
    description = "Service Account with required permissions for Onebank Functions"
}

# Roles
# roles/cloudfunctions.admin
# roles/cloudfunctions.developer
# roles/cloudfunctions.invoker (only works for 1st gen functions)
# roles/run.invoker (For 2nd gen function use cloud run's roles)
# roles/cloudfunctions.viewer

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