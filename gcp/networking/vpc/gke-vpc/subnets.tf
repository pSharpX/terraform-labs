resource "google_compute_subnetwork" "main_public_1" {
    name = "main-public-1"
    description = "Main Public Subnetwork for Onebank Resources"
    ip_cidr_range = "10.0.1.0/24"
    network = google_compute_network.onebank_network.id
    region = var.REGION
    stack_type = "IPV4_ONLY"
}

resource "google_compute_subnetwork" "main_public_2" {
    name = "main-public-2"
    description = "Main Public 2 Subnetwork for Onebank Resources"
    ip_cidr_range = "10.0.2.0/24"
    network = google_compute_network.onebank_network.id
    region = "europe-west1"
    stack_type = "IPV4_ONLY"
}

resource "google_compute_subnetwork" "main_public_3" {
    name = "main-public-3"
    description = "Main Public 3 Subnetwork for Onebank Resources"
    ip_cidr_range = "10.0.3.0/24"
    network = google_compute_network.onebank_network.id
    region = "us-east1"
    stack_type = "IPV4_ONLY"
}

resource "google_compute_subnetwork" "main_private_1" {
    name = "main-private-1"
    description = "Main Private Subnetwork for Onebank Resources"
    ip_cidr_range = "10.1.0.0/16"
    network = google_compute_network.onebank_network.id
    region = "us-west1"
    stack_type = "IPV4_ONLY"
    private_ip_google_access = true

    secondary_ip_range {
        range_name = "services-range"
        ip_cidr_range = "192.168.1.0/24"
    }
    secondary_ip_range {
        range_name = "pod-ranges"
        ip_cidr_range = "192.168.32.0/22"
    }
}

resource "google_compute_subnetwork" "main_private_2" {
    name = "main-private-2"
    description = "Main Private 2 Subnetwork for Onebank Resources"
    ip_cidr_range = "10.2.0.0/16"
    network = google_compute_network.onebank_network.id
    region = "us-south1"
    stack_type = "IPV4_ONLY"
    private_ip_google_access = true

    secondary_ip_range {
        range_name = "services-range"
        ip_cidr_range = "192.168.2.0/24"
    }
    secondary_ip_range {
        range_name = "pod-ranges"
        ip_cidr_range = "192.168.64.0/22"
    }
}

resource "google_compute_subnetwork" "main_private_3" {
    name = "main-private-3"
    description = "Main Private 3 Subnetwork for Onebank Resources"
    ip_cidr_range = "10.0.4.0/24"
    network = google_compute_network.onebank_network.id
    region = "us-west2"
    stack_type = "IPV4_ONLY"
    private_ip_google_access = true
}

resource "google_compute_router" "main_private_router_1" {
    name = "main-private-router-1"
    region = google_compute_subnetwork.main_private_1.region
    network = google_compute_network.onebank_network.id
}

resource "google_compute_router" "main_private_router_2" {
    name = "main-private-router-2"
    region = google_compute_subnetwork.main_private_2.region
    network = google_compute_network.onebank_network.id
}

resource "google_compute_router" "main_private_router_3" {
    name = "main-private-router-3"
    region = google_compute_subnetwork.main_private_3.region
    network = google_compute_network.onebank_network.id
}

resource "google_compute_router_nat" "main_private_router_nat_1" {
    name = "main-private-router-nat-1"
    router = google_compute_router.main_private_router_1.name
    region = google_compute_router.main_private_router_1.region
    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

    log_config {
        enable = true
        filter = "ALL" ## ERRORS_ONLY
    }
}

resource "google_compute_router_nat" "main_private_router_nat_2" {
    name = "main-private-router-nat-2"
    router = google_compute_router.main_private_router_2.name
    region = google_compute_router.main_private_router_2.region
    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

    log_config {
        enable = true
        filter = "ALL" ## ERRORS_ONLY
    }
}

resource "google_compute_router_nat" "main_private_router_nat_3" {
    name = "main-private-router-nat-3"
    router = google_compute_router.main_private_router_3.name
    region = google_compute_router.main_private_router_3.region
    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

    log_config {
        enable = true
        filter = "ALL" ## ERRORS_ONLY
    }
}