resource "google_compute_instance" "vm_client_1" {
    name = "onebank-vm-client-1"
    description = "VM Client to communicate with Regional internal ALB"
    machine_type = "e2-standard-2"
    labels = local.common_tags
    zone = data.google_compute_zones.private_1.names[0]

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = data.google_compute_network.default.id
        subnetwork = data.google_compute_subnetwork.private_1.id
    }
}

resource "google_compute_instance" "vm_client_2" {
    name = "onebank-vm-client-2"
    description = "VM Client to communicate with Regional internal ALB"
    machine_type = "e2-standard-2"
    labels = local.common_tags
    zone = data.google_compute_zones.private_2.names[0]

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = data.google_compute_network.default.id
        subnetwork = data.google_compute_subnetwork.private_2.id
    }
}