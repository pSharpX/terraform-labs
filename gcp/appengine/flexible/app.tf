# Notes:
# App Engine cannot be deleted once created. You need to delete the entire project.
# Only one App Engine resource can be created per project.

resource "google_project_service" "appengine_admin" {
    count = !(try(data.google_project_service.appengine_admin.id, null) != null) ? 0 : 1
    project = data.google_project.onebank.project_id
    service = "appengine.googleapis.com"
    disable_dependent_services = false
}

resource "google_project_service" "appengine_flex" {
    count = !(try(data.google_project_service.appengine_flex.id, null) != null) ? 0 : 1
    project = data.google_project.onebank.project_id
    service = "appengineflex.googleapis.com"
    disable_dependent_services = false
}

resource "google_app_engine_application" "onebank_app" {
    count = !(try(google_project_service.appengine_flex[0].id, null) != null) ? 0 : 1
    project = data.google_project.onebank.project_id
    location_id = var.LOCATION_ID
    serving_status = "SERVING"

    depends_on = [ 
        google_project_service.appengine_admin,
        google_project_service.appengine_flex
    ]
}
