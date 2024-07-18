data "google_project" "onebank" {
    project_id = var.PROJECT_ID
}

data "google_compute_network" "default" {
    name = var.DEFAULT_NETWORK
}

data "google_compute_subnetwork" "default" {
    name = var.DEFAULT_SUBNETWORK
    region = var.DEFAULT_SUBNETWORK_REGION
}

data "google_compute_zones" "locations" {
    region = data.google_compute_subnetwork.default.region
    status = "UP"
}

data "google_compute_machine_types" "general_purpose_e2_standard" {
    filter = "name = e2-standard* AND guestCpus >= 2 AND guestCpus <= 4 AND memoryMb >= 4096 AND memoryMb <= 8192"
    zone = data.google_compute_zones.locations.names[0]
}

data "google_client_config" "default" {
}
