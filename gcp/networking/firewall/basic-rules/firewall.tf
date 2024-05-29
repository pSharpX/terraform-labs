# Note: For INGRESS traffic, one of source_ranges, source_tags or source_service_accounts is required.

resource "google_compute_firewall" "allow_icmp" {
    name = "${local.applicationId}-allow-icmp"
    network = data.google_compute_network.default.name
    description = "Allow ICMP for network connectivty validation"
    direction = "INGRESS"
    priority = 65534
    source_ranges = [ "0.0.0.0/0" ] ## Allow inbound traffic from anywhere
    disabled = false

    allow {
        protocol = "icmp"
    }
}

resource "google_compute_firewall" "allow_ssh" {
    name = "${local.applicationId}-allow-ssh"
    network = data.google_compute_network.default.name
    description = "Allow SSH inbound traffic to instance in the default network"
    direction = "INGRESS"
    priority = 65534
    source_ranges = [ "0.0.0.0/0" ] ## Allow inbound traffic from anywhere
    disabled = false

    allow {
        protocol = "tcp"
        ports = ["22"]
    }
}

resource "google_compute_firewall" "allow_rdp" {
    name = "${local.applicationId}-allow-rdp"
    network = data.google_compute_network.default.name
    description = "Allow RDP inbound traffic to instance in the default network"
    direction = "INGRESS"
    priority = 65534
    source_ranges = [ "0.0.0.0/0" ] ## Allow inbound traffic from anywhere
    disabled = false

    allow {
        protocol = "tcp"
        ports = ["3389"]
    }
}
