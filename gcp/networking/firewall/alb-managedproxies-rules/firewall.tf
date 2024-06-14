## An ingress rule, applicable to the instances being load balanced, that allows TCP traffic on ports 80, 443, and 8080 from the internal Application Load Balancer's managed proxies.
## https://cloud.google.com/load-balancing/docs/l7-internal/setting-up-l7-cross-reg-internal#configure_firewall_rules

resource "google_compute_firewall" "allow_ilb_to_backends" {
    name = "${local.applicationId}-allow-ilb-to-backends"
    network = data.google_compute_network.default.name
    description = "Allow inbound traffic from the internal Application Load Balancer's managed proxies"
    direction = "INGRESS"
    priority = 65534
    source_ranges = var.PROXY_ONLY_SUBNETWORK_IP_RANGES ## allow all access from Proxy-Only subnetwork IP Address ranges
    target_tags   = ["http-server"]
    disabled = false

    allow {
        protocol = "tcp"
        ports    = ["80", "443", "8080"]
    }
}
