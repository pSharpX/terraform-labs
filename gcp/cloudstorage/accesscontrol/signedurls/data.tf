data "google_project" "onebank" {
    project_id = var.PROJECT_ID
}

data "google_storage_object_signed_url" "signed_url_for_download" {
    bucket = google_storage_bucket.default.name
    path = google_storage_bucket_object.site.output_name
    http_method = "GET" # ["GET" "HEAD" "PUT" "DELETE"]
    duration = "10m" # such as "300ms", "-1.5h" or "2h45m". Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h"
    credentials = base64decode(google_service_account_key.default_key.private_key)

    depends_on = [ google_storage_bucket_object.site ]
}

data "google_storage_object_signed_url" "signed_url_for_upload" {
    bucket = google_storage_bucket.default.name
    path = google_storage_bucket_object.site.output_name
    http_method = "PUT" # ["GET" "HEAD" "PUT" "DELETE"]
    duration = "10m" # such as "300ms", "-1.5h" or "2h45m". Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h"
    credentials = base64decode(google_service_account_key.default_key.private_key)

    depends_on = [ google_storage_bucket_object.site ]
}
