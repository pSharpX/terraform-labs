resource "google_compute_instance" "onebank_private_instance_1" {
    name = "${local.instance_name}-1"
    machine_type = "e2-standard-2"
    labels = local.instance_tags
    zone = var.SUBNET_ZONE

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        subnetwork = data.google_compute_subnetwork.default.name
    }
}

resource "google_compute_instance" "onebank_private_instance_2" {
    name = "${local.instance_name}-2"
    machine_type = "e2-standard-2"
    labels = local.instance_tags
    zone = var.SUBNET_ZONE

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-12"
        }
    }

    network_interface {
        subnetwork = data.google_compute_subnetwork.default.name
    }
}