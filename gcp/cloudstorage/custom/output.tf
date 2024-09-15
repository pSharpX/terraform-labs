output "project_number" {
    value = data.google_project.onebank.number
}

output "organization_id" {
    value = data.google_project.onebank.org_id
}

output "access_token" {
    value = data.google_service_account_access_token.default_access_token.access_token
    sensitive = true
}

output "bucket_url" {
    value = google_storage_bucket.default.url
}

output "object_output_name" {
    value = google_storage_bucket_object.site.output_name
}

output "object_self_link" {
    value = google_storage_bucket_object.site.self_link
}

output "object_media_link" {
    value = google_storage_bucket_object.site.media_link
}

# output "object_content" {
#     value = data.http.download_file_successful.response_body
# }