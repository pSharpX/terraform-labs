output "project_number" {
    value = data.google_project.onebank.number
}

output "organization_id" {
    value = data.google_project.onebank.org_id
}

output "bucket_url" {
    value = google_storage_bucket.default.url
}

output "object_name" {
    value = google_storage_bucket_object.site.output_name
}

output "object_selfLink" {
    value = google_storage_bucket_object.site.self_link
}

output "object_mediaLink" {
    value = google_storage_bucket_object.site.media_link
}