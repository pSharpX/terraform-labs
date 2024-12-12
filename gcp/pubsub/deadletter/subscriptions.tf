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

    dead_letter_policy {
        dead_letter_topic = google_pubsub_topic.onebank_dead_letter_topic.id
        max_delivery_attempts = 10
    }

    expiration_policy {
        ttl = ""
    }

    retry_policy {
        minimum_backoff = "10s"
    }
}

resource "google_pubsub_subscription" "push_notification_subscription" {
    name = local.push_notification_subscription
    topic = google_pubsub_topic.onebank_topic.id
    labels = local.common_tags

    ack_deadline_seconds = 20

    message_retention_duration = "1200s"
    retain_acked_messages = false

    filter = <<EOF
        attributes.type = "PUSH"
    EOF

    dead_letter_policy {
        dead_letter_topic = google_pubsub_topic.onebank_dead_letter_topic.id
        max_delivery_attempts = 10
    }

    expiration_policy {
        ttl = ""
    }

    retry_policy {
        minimum_backoff = "10s"
    }
}

resource "google_pubsub_subscription" "sms_notification_subscription" {
    name = local.sms_notification_subscription
    topic = google_pubsub_topic.onebank_topic.id
    labels = local.common_tags

    ack_deadline_seconds = 20

    message_retention_duration = "1200s"
    retain_acked_messages = false

    filter = <<EOF
        attributes.type = "SMS"
    EOF

    dead_letter_policy {
        dead_letter_topic = google_pubsub_topic.onebank_dead_letter_topic.id
        max_delivery_attempts = 10
    }

    expiration_policy {
        ttl = ""
    }

    retry_policy {
        minimum_backoff = "10s"
    }
}

######################### Dead Letter Subscription  #########################

resource "google_pubsub_subscription" "dead_letter_subscription" {
    name = local.dead_letter_subscription
    topic = google_pubsub_topic.onebank_dead_letter_topic.id
    labels = local.common_tags

    ack_deadline_seconds = 20

    message_retention_duration = "1200s"
    retain_acked_messages = false

    expiration_policy {
        ttl = ""
    }

    retry_policy {
        minimum_backoff = "12s"
    }
}

#############################################################################