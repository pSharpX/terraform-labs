resource "google_compute_instance" "onebank_instance" {
    name = "onebank-instance"
    machine_type = "e2-standard-2"

    tags = [ "ssh", "http" ]

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = "default"

        access_config {
            # Include this section to give the VM an external IP address
        }
    }
}