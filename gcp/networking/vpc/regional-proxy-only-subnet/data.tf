data "google_compute_network" "onebank_network" {
    name = var.DEFAULT_NETWORK
}

data "google_compute_subnetwork" "private_1" {
    name = var.SUBNET_1
    region = var.REGION_SUBNET_1
}

data "google_compute_zones" "private_1" {
    region = var.REGION_SUBNET_1
    status = "UP"
}

data "google_compute_subnetwork" "private_2" {
    name = var.SUBNET_2
    region = var.REGION_SUBNET_2
}

data "google_compute_zones" "private_2" {
    region = var.REGION_SUBNET_2
    status = "UP"
}