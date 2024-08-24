output "project_number" {
    value = data.google_project.onebank.number
}

output "organization_id" {
    value = data.google_project.onebank.org_id
}

output "default_repository_url" {
    value = local.repository_url
}

output "service_id" {
    value = google_cloud_run_v2_service.onebank_app.id
}

output "service_url" {
    value = google_cloud_run_v2_service.onebank_app.uri
}