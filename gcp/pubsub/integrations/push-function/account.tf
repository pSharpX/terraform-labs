resource "google_project_service_identity" "pubsub_identity" {
    provider = google-beta
    service = "pubsub.googleapis.com"
}
