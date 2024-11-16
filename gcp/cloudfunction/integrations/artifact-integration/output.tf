output "project_number" {
    value = data.google_project.onebank.number
}

output "organization_id" {
    value = data.google_project.onebank.org_id
}

output "bucket_url" {
    value = google_storage_bucket.default.url
}

output "function_url" {
    value = google_cloudfunctions2_function.main.url
}

output "function_service_url" {
    value = google_cloudfunctions2_function.main.service_config[0].uri
}

output "function_response" {
    value = data.http.test_createtask_fn.response_body
}