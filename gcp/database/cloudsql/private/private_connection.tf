# https://cloud.google.com/vpc/docs/configure-private-services-access#terraform_1

resource "google_compute_global_address" "private_ip_address" {
    name = "private-ip-address"
    description = "IP address range for Private Connections"
    purpose = "VPC_PEERING"
    ip_version = "IPV4"
    address_type = "INTERNAL"
    prefix_length = "16"
    network = data.google_compute_network.default.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
    network = data.google_compute_network.default.id
    service = "servicenetworking.googleapis.com"
    reserved_peering_ranges = [ google_compute_global_address.private_ip_address.name ]
}