data "google_project" "onebank" {
    project_id = var.PROJECT_ID
}

data "google_artifact_registry_repository" "default" {
    location = var.REGION
    repository_id = var.REPOSITORY_NAME
}

data "google_compute_network" "default" {
    name = var.NETWORK
}

data "google_compute_zones" "zones" {
    region = var.REGION
    status = "UP"
}