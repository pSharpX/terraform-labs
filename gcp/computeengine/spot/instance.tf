resource "google_compute_instance" "onebank_instance" {
    name = "onebank-instance"
    description = "Instance where all workloads are executed"
    machine_type = "e2-standard-2"
    hostname = "onebank.com"

    tags = [ "ssh", "http" ]

    boot_disk {
        initialize_params {
            image = data.google_compute_image.ubuntu.self_link
        }
    }

    scheduling {
        preemptible = true
        automatic_restart = false
        provisioning_model = "SPOT"
    }

    network_interface {
        network = "default"

        access_config {
            # Include this section to give the VM an external IP address
        }
    }

    metadata = {
        ssh-keys = "${var.USERNAME}:${file(var.PUBLIC_KEY)}"
    }
}