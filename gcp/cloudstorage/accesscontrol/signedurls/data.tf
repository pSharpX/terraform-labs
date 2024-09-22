data "google_project" "onebank" {
    project_id = var.PROJECT_ID
}

data "google_storage_object_signed_url" "signed_object_url" {
    bucket = google_storage_bucket.default.name
    path = google_storage_bucket_object.site.output_name
    duration = "3m" # such as "300ms", "-1.5h" or "2h45m". Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h"

    depends_on = [ google_storage_bucket_object.site ]
}
