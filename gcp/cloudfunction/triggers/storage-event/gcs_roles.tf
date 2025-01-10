# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function#example-usage---cloudfunctions2-basic-gcs

resource "google_project_iam_member" "gcs_pubsub_publishing" {
  project = data.google_project.onebank.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}