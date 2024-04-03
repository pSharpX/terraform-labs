resource "google_compute_firewall" "allow_icmp" {
    name = "${local.applicationId}-allow-icmp"
    network = data.google_compute_network.default.name
    description = "Allow ICMP for network connectivty validation"
    source_tags = [ "onebank" ]

    allow {
        protocol = "icmp"
    }
}

resource "google_compute_firewall" "allow_http" {
    name = "${local.applicationId}-allow-http"
    network = data.google_compute_network.default.name
    description = "Allow HTTP inbound traffic to the instance in the default network"
    direction = "INGRESS"
    source_ranges = [ "0.0.0.0/0" ]
    source_tags = [ "http" ]

    allow {
        protocol = "tcp"
        ports = [ "80" ]
    }
}

resource "google_compute_firewall" "allow_ssh" {
    name = "${local.applicationId}-allow-ssh"
    network = data.google_compute_network.default.name
    description = "Allow SSH inbound traffic to instance in the default network"
    direction = "INGRESS"
    source_ranges = [ "0.0.0.0/0" ]
    source_tags = ["ssh"]

    allow {
        protocol = "tcp"
        ports = ["22"]
    }
}