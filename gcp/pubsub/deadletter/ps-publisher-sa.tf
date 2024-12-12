# https://cloud.google.com/pubsub/docs/access-control

resource "google_service_account" "publisher_sa" {
    project = data.google_project.onebank.project_id
    account_id = local.publisher_sa_name
    display_name = "Service Account for OneBank TaskMaster application (Publisher)"
    description = "Service Account for PubSub integration"
}

# Roles
# roles/pubsub.admin
# roles/pubsub.editor
# roles/pubsub.publisher
# roles/pubsub.subscriber
# roles/pubsub.viewer

resource "google_pubsub_topic_iam_member" "publisher_member" {
  project = google_pubsub_topic.onebank_topic.project
  topic = google_pubsub_topic.onebank_topic.name
  role = "roles/pubsub.publisher"
  member = "serviceAccount:${google_service_account.publisher_sa.email}"
}

resource "google_service_account_key" "publisher_sa_key" {
    service_account_id = google_service_account.publisher_sa.name
}

resource "local_sensitive_file" "publisher_account_credentials" {
    content = base64decode(google_service_account_key.publisher_sa_key.private_key)
    filename = "./configs/${local.publisher_sa_name}.json"
}

data "google_service_account_access_token" "publisher_sa_access_token" {
    target_service_account = google_service_account.publisher_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}
