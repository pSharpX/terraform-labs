# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function_iam
# https://cloud.google.com/functions/docs/reference/iam/roles
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account_id_token

resource "google_service_account" "eventarc_invoker_sa" {
    project = data.google_project.onebank.project_id
    account_id = "${local.applicationId}-eventarc-invoker-sa"
    display_name = "Function EventArc Receiver Service Account"
    description = "Service Account with EventArc Receiver Permission"
}

resource "google_project_iam_member" "eventarc_event_receiver_permission" {
  project = data.google_project.onebank.project_id
  role = "roles/eventarc.eventReceiver"
  member = "serviceAccount:${google_service_account.eventarc_invoker_sa.email}"
}

resource "google_project_iam_member" "eventarc_cfn_invoker_permission" {
    project = data.google_project.onebank.project_id
    role = "roles/cloudfunctions.invoker"
    member = "serviceAccount:${google_service_account.eventarc_invoker_sa.email}"
}

resource "google_project_iam_member" "eventarc_run_invoker_permission" {
    project = data.google_project.onebank.project_id
    role = "roles/run.invoker"
    member = "serviceAccount:${google_service_account.eventarc_invoker_sa.email}"
}

resource "time_sleep" "wait_60s_for_eventarc_invoker" {
  create_duration = "60s"

  depends_on = [
    google_project_iam_member.eventarc_event_receiver_permission,
    google_project_iam_member.eventarc_cfn_invoker_permission,
    google_project_iam_member.eventarc_run_invoker_permission
  ]
}