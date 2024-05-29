## allows ingress traffic from the IP range 35.235.240.0/20. This range contains all IP addresses that IAP uses for TCP forwarding.
## https://cloud.google.com/iap/docs/using-tcp-forwarding

resource "google_compute_firewall" "allow_ssh_from_iap" {
    name = "${local.applicationId}-allow-ssh-iap"
    network = data.google_compute_network.default.name
    description = "Allow SSH inbound traffic from IAP to instance in the default network"
    direction = "INGRESS"
    priority = 65534
    source_ranges = [ "35.235.240.0/20" ] ## Using IAP for TCP forwarding
    disabled = false

    allow {
        protocol = "tcp"
        ports = ["22"]
    }
}

resource "google_compute_firewall" "allow_rdp_from_iap" {
    name = "${local.applicationId}-allow-rdp-iap"
    network = data.google_compute_network.default.name
    description = "Allow RDP inbound traffic from IAP to instance in the default network"
    direction = "INGRESS"
    priority = 65534
    source_ranges = [ "35.235.240.0/20" ] ## Using IAP for TCP forwarding
    disabled = false

    allow {
        protocol = "tcp"
        ports = ["3389"]
    }
}
