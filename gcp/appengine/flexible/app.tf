resource "google_app_engine_application" "onebank_app" {
    project = data.google_project.onebank.project_id
    location_id = var.LOCATION_ID
    serving_status = "SERVING"
}

resource "google_project_service" "appengine_flex" {
    count = !(try(data.google_project_service.appengine_flex.service, null) != null) ? 0 : 1
    project = data.google_project.onebank.project_id
    service = "appengineflex.googleapis.com"
    disable_dependent_services = false
}
