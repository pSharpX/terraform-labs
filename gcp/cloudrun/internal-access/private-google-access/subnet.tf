# https://cloud.google.com/vpc/docs/private-google-access

resource "google_compute_subnetwork" "pga_subnet" {
    name = local.pga_subnet
    description = "VPC Subnetwork with Private Google Access enabled"
    region = var.REGION
    ip_cidr_range = "10.0.5.0/24"
    network = data.google_compute_network.default.id
    stack_type = "IPV4_ONLY"
    private_ip_google_access = true
}
