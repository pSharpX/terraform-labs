# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function_iam
# https://cloud.google.com/functions/docs/reference/iam/roles
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account_id_token

resource "google_service_account" "invoker_sa" {
    project = data.google_project.onebank.project_id
    account_id = "${local.applicationId}-fn-invoker-sa"
    display_name = "Function Invoker Service Account"
    description = "Service Account with Function Invoker Permission"
}

# Roles
# roles/cloudfunctions.admin
# roles/cloudfunctions.developer
# roles/cloudfunctions.invoker (only works for 1st gen functions)
# roles/run.invoker (For 2nd gen function use cloud run's roles)
# roles/cloudfunctions.viewer

resource "google_service_account_iam_member" "cfn_token_creator_permission" {
    service_account_id = google_service_account.invoker_sa.name
    role = "roles/iam.serviceAccountTokenCreator"
    member = "serviceAccount:${google_service_account.invoker_sa.email}"
}

resource "google_cloudfunctions2_function_iam_member" "cfn_invoker_permission" {
    location = google_cloudfunctions2_function.main.location
    cloud_function = google_cloudfunctions2_function.main.name
    role = "roles/cloudfunctions.invoker"
    member = "serviceAccount:${google_service_account.invoker_sa.email}"
}

resource "google_cloud_run_service_iam_member" "run_invoker_permission" {
    location = google_cloudfunctions2_function.main.location
    service = google_cloudfunctions2_function.main.name
    role = "roles/run.invoker"
    member = "serviceAccount:${google_service_account.invoker_sa.email}"
}

data "google_service_account_access_token" "invoker_access_token" {
    target_service_account = google_service_account.invoker_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}

data "google_service_account_id_token" "invoker_oidc_token" {
    target_service_account = google_service_account.invoker_sa.email
    target_audience = google_cloudfunctions2_function.main.url
}

resource "time_sleep" "wait_60s_for_invoker" {
  create_duration = "60s"

  depends_on = [
    google_cloudfunctions2_function_iam_member.cfn_invoker_permission,
    google_cloud_run_service_iam_member.run_invoker_permission,
    google_service_account_iam_member.cfn_token_creator_permission
  ]
}