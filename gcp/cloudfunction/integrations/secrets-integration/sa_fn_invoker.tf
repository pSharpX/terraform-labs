# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function_iam
# https://cloud.google.com/functions/docs/reference/iam/roles

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

resource "google_cloudfunctions2_function_iam_member" "cfn_allUsers" {
    location = google_cloudfunctions2_function.main.location
    cloud_function = google_cloudfunctions2_function.main.name
    role = "roles/cloudfunctions.invoker"
    member = "allUsers"
}

resource "google_cloud_run_service_iam_member" "run_allUsers" {
    location = google_cloudfunctions2_function.main.location
    service = google_cloudfunctions2_function.main.name
    role = "roles/run.invoker"
    member = "allUsers"
}

resource "time_sleep" "wait_60s_for_invoker" {
  create_duration = "60s"

  depends_on = [
    google_cloudfunctions2_function_iam_member.cfn_allUsers,
    google_cloud_run_service_iam_member.run_allUsers
  ]
}