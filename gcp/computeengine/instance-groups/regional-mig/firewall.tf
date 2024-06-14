resource "google_compute_firewall" "allow_http" {
    name = "${local.applicationId}-allow-http"
    network = data.google_compute_network.default.name
    description = "Allow HTTP inbound traffic to the instance in the default network"
    direction = "INGRESS"
    source_ranges = [ "0.0.0.0/0" ]
    target_tags = [ "http-server" ]

    allow {
        protocol = "tcp"
        ports = [ "80" ]
    }
}