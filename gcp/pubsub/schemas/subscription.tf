# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription

resource "google_pubsub_subscription" "email_notification_subscription" {
    name = local.email_notification_subscription
    topic = google_pubsub_topic.onebank_topic.id
    labels = local.common_tags

    ack_deadline_seconds = 20

    message_retention_duration = "1200s"
    retain_acked_messages = false

    retry_policy {
        minimum_backoff = "10s"
    }
}
