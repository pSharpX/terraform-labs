resource "google_compute_instance" "onebank_instance" {
    name = local.instance_name
    machine_type = "e2-standard-2"
    labels = local.instance_tags
    tags = [ "onebank", "http", "ssh" ]

    boot_disk {
        initialize_params {
            image = data.google_compute_image.ubuntu.self_link
            size = 50
        }
    }
    
    network_interface {
        network = "default"

        access_config {
            # Include this section to give the VM an external IP address
        }
    }

    metadata_startup_script = data.template_file.docker_script.rendered
}