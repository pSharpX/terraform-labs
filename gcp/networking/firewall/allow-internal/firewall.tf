resource "google_compute_firewall" "allow_internal" {
    name = "${local.applicationId}-allow-internal"
    network = data.google_compute_network.default.name
    description = "Allow Internal traffic on the default network"
    direction = "INGRESS"
    priority = 65534
    source_ranges = var.IPV4_RANGES
    disabled = false

    allow {
        protocol = "icmp"
    }

    allow {
        protocol = "tcp"
        ports = ["0-65535"]
    }

    allow {
        protocol = "udp"
        ports = ["0-65535"]
    }
}
