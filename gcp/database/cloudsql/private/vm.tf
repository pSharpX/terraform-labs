resource "google_compute_instance" "vm_client_1" {
    name = "onebank-vm-client-1"
    description = "VM Client to communicate with Private Cloud SQL"
    machine_type = "e2-standard-2"
    labels = local.common_tags
    zone = data.google_compute_zones.zones.names[0]

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = data.google_compute_network.default.id
        subnetwork = data.google_compute_subnetwork.default.id
    }

    metadata_startup_script = file(var.PROVISIONER_SCRIPT_PATH)
}