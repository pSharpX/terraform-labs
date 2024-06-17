# resource "google_compute_subnetwork" "main_private_1_proxy_only" {
#     provider = google-beta
#     name = "main-private-1-proxy-only"
#     description = "Main Private Proxy-Only Subnetwork for ALB"
#     ip_cidr_range = var.PROXY_ONLY_SUBNETWORK_IP_RANGES[0]
#     network = data.google_compute_network.onebank_network.id
#     purpose = "GLOBAL_MANAGED_PROXY"
#     role = "ACTIVE"
#     region = var.REGION_SUBNET_1
#     stack_type = "IPV4_ONLY"
# }

# resource "google_compute_subnetwork" "main_private_2_proxy_only" {
#     provider = google-beta
#     name = "main-private-2-proxy-only"
#     description = "Main Private 2 Proxy-Only Subnetwork for ALB"
#     ip_cidr_range = var.PROXY_ONLY_SUBNETWORK_IP_RANGES[1]
#     network = data.google_compute_network.onebank_network.id
#     purpose = "GLOBAL_MANAGED_PROXY"
#     role = "ACTIVE"
#     region = var.REGION_SUBNET_2
#     stack_type = "IPV4_ONLY"
# }