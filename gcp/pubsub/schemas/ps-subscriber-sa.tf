# https://cloud.google.com/pubsub/docs/access-control

resource "google_service_account" "subscriber_sa" {
    project = data.google_project.onebank.project_id
    account_id = local.subscriber_sa_name
    display_name = "Service Account for OneBank TaskMaster application (Subscriber)"
    description = "Service Account for PubSub integration"
}

# Roles
# roles/pubsub.admin
# roles/pubsub.editor
# roles/pubsub.publisher
# roles/pubsub.subscriber
# roles/pubsub.viewer

resource "google_pubsub_subscription_iam_member" "subscriber_member" {
  subscription = google_pubsub_subscription.email_notification_subscription.name
  role = "roles/pubsub.subscriber"
  member = "serviceAccount:${google_service_account.subscriber_sa.email}"
}

resource "google_service_account_key" "subscriber_sa_key" {
    service_account_id = google_service_account.subscriber_sa.name
}

resource "local_sensitive_file" "subscriber_account_credentials" {
    content = base64decode(google_service_account_key.subscriber_sa_key.private_key)
    filename = "./configs/${local.subscriber_sa_name}.json"
}

data "google_service_account_access_token" "subscriber_sa_access_token" {
    target_service_account = google_service_account.subscriber_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}
