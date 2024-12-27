# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription

resource "google_pubsub_subscription" "email_notification_subscription" {
    name = local.email_notification_subscription
    topic = google_pubsub_topic.onebank_topic.id
    labels = local.common_tags

    ack_deadline_seconds = 20

    message_retention_duration = "1200s"
    retain_acked_messages = false

    filter = <<EOF
        attributes.type = "EMAIL"
    EOF

    expiration_policy {
        ttl = ""
    }

    retry_policy {
        minimum_backoff = "10s"
    }

    push_config {
        push_endpoint = google_cloudfunctions2_function.main.url
        oidc_token {
            service_account_email = google_service_account.invoker_sa.email
        }
        no_wrapper {
            write_metadata = true
        }
    }
}
