resource "google_compute_instance_template" "backend" {
    name = "onebank-backend-template"
    description = "This template is used to create backend server instances."

    tags = [ "ssh", "http", "onebank" ]
    labels = local.common_tags

    instance_description = "Backend Server Instances"
    machine_type = data.google_compute_machine_types.general_purpose_e2_standard.machine_types[0].name

    disk {
        source_image = data.google_compute_image.ubuntu.self_link
        auto_delete = true
        boot = true
        disk_size_gb = 50
    }

    network_interface {
        network = data.google_compute_network.default.name

        access_config {
            # Include this section to give the VM an external IP address
        }
    }

    metadata_startup_script = file(var.PROVISIONER_SCRIPT_PATH)
}
resource "google_compute_instance_from_template" "onebank_instances" {
    count = var.INSTANCE_COUNT
    name = "${local.instance_name}-${count.index}"
    source_instance_template = google_compute_instance_template.backend.self_link_unique
    labels = local.instance_tags
}