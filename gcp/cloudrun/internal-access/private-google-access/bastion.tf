resource "google_compute_instance" "vm_client_1" {
    name = "onebank-bastion-1"
    description = "VM Client to communicate with Private Cloud Run"
    machine_type = "e2-standard-2"
    labels = local.common_tags
    zone = data.google_compute_zones.zones.names[0]

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-12"
        }
    }

    network_interface {
        network = data.google_compute_network.default.id
        subnetwork = google_compute_subnetwork.pga_subnet.id
    }

    service_account {
        email = google_service_account.client_app.email
        scopes = [ "cloud-platform", "userinfo-email" ]
    }
}