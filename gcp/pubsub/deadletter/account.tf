resource "google_project_service_identity" "pubsub_identity" {
    provider = google-beta
    service = "pubsub.googleapis.com"
}

resource "google_pubsub_topic_iam_member" "dlt_publisher_member" {
  project = google_pubsub_topic.onebank_dead_letter_topic.project
  topic = google_pubsub_topic.onebank_dead_letter_topic.name
  role = "roles/pubsub.publisher"
  member = "serviceAccount:${google_project_service_identity.pubsub_identity.email}"
}

resource "google_pubsub_subscription_iam_member" "dlt_email_subscriber_member" {
  subscription = google_pubsub_subscription.email_notification_subscription.name
  role = "roles/pubsub.subscriber"
  member = "serviceAccount:${google_project_service_identity.pubsub_identity.email}"
}

resource "google_pubsub_subscription_iam_member" "dlt_push_subscriber_member" {
  subscription = google_pubsub_subscription.push_notification_subscription.name
  role = "roles/pubsub.subscriber"
  member = "serviceAccount:${google_project_service_identity.pubsub_identity.email}"
}

resource "google_pubsub_subscription_iam_member" "dlt_sms_subscriber_member" {
  subscription = google_pubsub_subscription.sms_notification_subscription.name
  role = "roles/pubsub.subscriber"
  member = "serviceAccount:${google_project_service_identity.pubsub_identity.email}"
}