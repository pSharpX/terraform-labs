output "project_number" {
    value = data.google_project.onebank.number
}

output "topic_name" {
    value = google_pubsub_topic.onebank_topic.name
}

output "topic_id" {
    value = google_pubsub_topic.onebank_topic.id
}

output "subscription_name" {
    value = google_pubsub_subscription.email_notification_subscription.name
}

output "subscription_id" {
    value = google_pubsub_subscription.email_notification_subscription.id
}