output "project_number" {
    value = data.google_project.onebank.number
}

output "topic_name" {
    value = google_pubsub_topic.onebank_topic.name
}

output "topic_id" {
    value = google_pubsub_topic.onebank_topic.id
}

output "schema_id" {
    value = google_pubsub_schema.notification_message_schema.id
}

output "schema_name" {
    value = google_pubsub_schema.notification_message_schema.name
}

output "subscription_name" {
    value = google_pubsub_subscription.email_notification_subscription.name
}

output "subscription_id" {
    value = google_pubsub_subscription.email_notification_subscription.id
}