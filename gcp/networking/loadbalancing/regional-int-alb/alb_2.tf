resource "google_compute_region_url_map" "backend_map_2" {
    name = "onebank-xlb-urlmap-2"
    description = "The main URL Map for LB routing traffic to backend servers groups"
    region = var.REGION_SUBNET_2
    default_service = google_compute_region_backend_service.backend_2.id
}

resource "google_compute_region_target_http_proxy" "proxy_2" {
    name = "onebank-target-proxy-2"
    region = var.REGION_SUBNET_2
    url_map = google_compute_region_url_map.backend_map_2.id
}

resource "google_compute_forwarding_rule" "fwd_rule_2" {
    name = "gil7forwarding-rule-2"
    region = var.REGION_SUBNET_2
    ip_protocol = "TCP"
    load_balancing_scheme = "INTERNAL_MANAGED"
    port_range = "80"
    target = google_compute_region_target_http_proxy.proxy_2.id
    network = data.google_compute_network.default.id
    subnetwork = data.google_compute_subnetwork.private_2.id
}