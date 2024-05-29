data "google_compute_network" "default" {
    name = var.DEFAULT_NETWORK
}

data "google_compute_subnetwork" "default" {
    name = var.DEFAULT_SUBNET
    region = "us-west1"
}
