# https://cloud.google.com/vpc/docs/configure-private-services-access#terraform_1
# https://github.com/hashicorp/terraform-provider-google/issues/3294#issuecomment-508682983

resource "google_compute_global_address" "private_ip_address" {
    provider = google-beta
    name = local.private_ip_range
    description = "IP address range for Private Connections"
    purpose = "VPC_PEERING"
    ip_version = "IPV4"
    address_type = "INTERNAL"
    prefix_length = "16"
    network = data.google_compute_network.default.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
    provider = google-beta
    network = data.google_compute_network.default.id
    service = "servicenetworking.googleapis.com"
    #reserved_peering_ranges = [  ]
    reserved_peering_ranges = [ google_compute_global_address.private_ip_address.name ]
}