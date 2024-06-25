data "google_project" "onebank" {
    project_id = var.PROJECT_ID
}

data "google_project_service" "appengine_flex" {
    project = var.PROJECT_ID
    service = "appengineflex.googleapis.com"
}