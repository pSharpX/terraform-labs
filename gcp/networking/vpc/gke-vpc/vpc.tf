resource "google_compute_network" "onebank_network" {
    name = "onebank-network"
    description = "VPC Network used for Onebank Resources"
    auto_create_subnetworks = false
    routing_mode = "REGIONAL"
    delete_default_routes_on_create = false
}