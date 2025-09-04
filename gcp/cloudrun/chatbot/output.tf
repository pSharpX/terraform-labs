output "project_number" {
    value = data.google_project.onebank.number
}

output "organization_id" {
    value = data.google_project.onebank.org_id
}

output "service_id" {
    value = google_cloud_run_v2_service.chatbot_app.id
}

output "service_url" {
    value = google_cloud_run_v2_service.chatbot_app.uri
}