## allows ingress traffic from the IP range "130.211.0.0/22", "35.191.0.0/16". This range contains all IP addresses for health check.
## https://cloud.google.com/load-balancing/docs/health-check-concepts#ip-ranges
## ["130.211.0.0/22", "35.191.0.0/16", "35.235.240.0/20"]

resource "google_compute_firewall" "allow_health_check_lb_probers" {
    name = "${local.applicationId}-allow-health-check-lb"
    network = data.google_compute_network.default.name
    description = "Allow inbound traffic from health check (LB)"
    direction = "INGRESS"
    priority = 65534
    source_ranges = [ "130.211.0.0/22", "35.191.0.0/16" ] ## allow all access from health check ranges
    disabled = false

    allow {
        protocol = "tcp"
    }
}
