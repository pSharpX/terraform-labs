# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic
# https://cloud.google.com/pubsub/docs/admin#managing_topics

resource "google_pubsub_topic" "onebank_topic" {
    name = local.topic_name
    labels = local.common_tags

    message_retention_duration = "86600s"
    schema_settings {
        schema = google_pubsub_schema.notification_message_schema.id
        encoding = "JSON"
    }
}