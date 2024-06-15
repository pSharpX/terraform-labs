resource "google_compute_region_url_map" "backend_map_1" {
    name = "onebank-xlb-urlmap-1"
    description = "The main URL Map for LB routing traffic to backend servers groups"
    region = var.REGION_SUBNET_1
    default_service = google_compute_region_backend_service.backend_1.id
}

resource "google_compute_region_target_http_proxy" "proxy_1" {
    name = "onebank-target-proxy-1"
    region = var.REGION_SUBNET_1
    url_map = google_compute_region_url_map.backend_map_1.id
}

resource "google_compute_forwarding_rule" "fwd_rule_1" {
    name = "gil7forwarding-rule-1"
    region = var.REGION_SUBNET_1
    ip_protocol = "TCP"
    load_balancing_scheme = "INTERNAL_MANAGED"
    port_range = "80"
    target = google_compute_region_target_http_proxy.proxy_1.id
    network = data.google_compute_network.default.id
    subnetwork = data.google_compute_subnetwork.private_1.id
}