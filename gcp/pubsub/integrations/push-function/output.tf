output "project_number" {
    value = data.google_project.onebank.id
}

output "organization_id" {
    value = data.google_project.onebank.org_id
}

output "topic_name" {
    value = google_pubsub_topic.onebank_topic.name
}

output "topic_id" {
    value = google_pubsub_topic.onebank_topic.id
}

output "email_subscription_name" {
    value = google_pubsub_subscription.email_notification_subscription.name
}

output "bucket_url" {
    value = google_storage_bucket.default.url
}

output "secrets_id" {
    value = [for o in google_secret_manager_secret.cf_secrets: o.id]
}

output "function_url" {
    value = google_cloudfunctions2_function.main.url
}

output "function_service_url" {
    value = google_cloudfunctions2_function.main.service_config[0].uri
}

output "function_response" {
    value = data.http.test_emailsender_fn.response_body
}