output "project_number" {
    value = data.google_project.onebank.number
}

output "organization_id" {
    value = data.google_project.onebank.org_id
}

# output "app_url" {
#     value = google_app_engine_application.onebank_app.default_hostname
# }
