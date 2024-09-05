# https://cloud.google.com/run/docs/configuring/vpc-direct-vpc
# https://cloud.google.com/run/docs/configuring/vpc-direct-vpc#direct-vpc-ip-allocation
# https://cloud.google.com/vpc/docs/private-google-access

resource "google_compute_subnetwork" "directvpc_subnet" {
    name = local.directvpc_subnet
    description = "Direct VPC Subnetwork for accessing resources in VPC"
    region = var.REGION
    ip_cidr_range = "10.0.4.0/24"
    network = data.google_compute_network.default.id
    stack_type = "IPV4_ONLY"
    private_ip_google_access = true
}
