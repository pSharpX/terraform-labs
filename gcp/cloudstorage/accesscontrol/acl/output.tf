output "project_number" {
    value = data.google_project.onebank.number
}

output "organization_id" {
    value = data.google_project.onebank.org_id
}

output "assets_bucket_url" {
    value = google_storage_bucket.assets.url
}

output "web_bucket_url" {
    value = google_storage_bucket.web.url
}
