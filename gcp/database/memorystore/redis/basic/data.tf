data "google_project" "onebank" {
    project_id = var.PROJECT_ID
}

data "google_compute_network" "default" {
    name = var.NETWORK
}

data "google_compute_zones" "zones" {
    region = var.REGION
    status = "UP"
}
