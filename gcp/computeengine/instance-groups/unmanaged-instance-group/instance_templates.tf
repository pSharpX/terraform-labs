resource "google_compute_instance_template" "debian_worker" {
    name = "debian-worker-template"
    description = "This template is used to create Debian Backend worker instances."

    tags = [ "ssh", "http", "onebank", "worker" ]
    labels = local.common_tags

    instance_description = "Backend worker Instances"
    machine_type = data.google_compute_machine_types.general_purpose_e2_standard.machine_types[0].name

    disk {
        source_image = data.google_compute_image.debian.self_link
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

    metadata_startup_script = file(var.PROVISIONER_SCRIPT_PATHS.DEBIAN)
    metadata = {
        ssh-Keys = "${var.USERNAME}:${file(var.PUBLIC_KEY)}"
    }
}

resource "google_compute_instance_template" "ubuntu_worker" {
    name = "ubuntu-worker-template"
    description = "This template is used to create Ubuntu Backend worker instances."

    tags = [ "ssh", "http", "onebank", "worker" ]
    labels = local.common_tags

    instance_description = "Backend worker Instances"
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

    metadata_startup_script = file(var.PROVISIONER_SCRIPT_PATHS.UBUNTU)
    metadata = {
        ssh-Keys = "${var.USERNAME}:${file(var.PUBLIC_KEY)}"
    }
}

resource "google_compute_instance_template" "fedora_worker" {
    name = "fedora-worker-template"
    description = "This template is used to create Fedora Backend worker instances."

    tags = [ "ssh", "http", "onebank", "worker" ]
    labels = local.common_tags

    instance_description = "Backend worker Instances"
    machine_type = data.google_compute_machine_types.general_purpose_e2_standard.machine_types[0].name

    disk {
        source_image = data.google_compute_image.fedora.self_link
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

    metadata_startup_script = file(var.PROVISIONER_SCRIPT_PATHS.FEDORA)
    metadata = {
        ssh-Keys = "${var.USERNAME}:${file(var.PUBLIC_KEY)}"
    }
}

resource "google_compute_instance_template" "rhel_worker" {
    name = "rhel-worker-template"
    description = "This template is used to create RHEL Backend worker instances."

    tags = [ "ssh", "http", "onebank", "worker" ]
    labels = local.common_tags

    instance_description = "Backend worker Instances"
    machine_type = data.google_compute_machine_types.general_purpose_e2_standard.machine_types[0].name

    disk {
        source_image = data.google_compute_image.rhel.self_link
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

    metadata_startup_script = file(var.PROVISIONER_SCRIPT_PATHS.RHEL)
    metadata = {
        ssh-Keys = "${var.USERNAME}:${file(var.PUBLIC_KEY)}"
    }
}