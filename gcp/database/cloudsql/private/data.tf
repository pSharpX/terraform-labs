data "google_project" "onebank" {
    project_id = var.PROJECT_ID
}

data "google_compute_network" "default" {
    name = var.NETWORK
}

data "google_compute_subnetwork" "default" {
    name = var.SUBNETWORK
    region = var.SUBNETWORK_REGION
}


data "google_compute_zones" "zones" {
    region = var.SUBNETWORK_REGION
    status = "UP"
}