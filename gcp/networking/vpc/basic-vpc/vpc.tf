resource "google_compute_network" "onebank_network" {
    name = "onebank-default-network"
    description = "Default VPC Network used for Onebank Resources"
    auto_create_subnetworks = true
    routing_mode = "REGIONAL"
    delete_default_routes_on_create = false
}