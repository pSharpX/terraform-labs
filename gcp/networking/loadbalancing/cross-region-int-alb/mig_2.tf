resource "google_compute_instance_template" "backend_template_2" {
    name = "onebank-backend-template-2"
    description = "This template is used to create backend server instances"

    tags = [ "http-server", "onebank" ]
    labels = local.common_tags

    instance_description = "Backend Server Instances"
    machine_type = data.google_compute_machine_types.general_purpose_e2_standard.machine_types[0].name
    region = data.google_compute_subnetwork.private_2.region

    disk {
        source_image = data.google_compute_image.ubuntu.self_link
        auto_delete = true
        boot = true
        disk_size_gb = 50
    }

    network_interface {
        network = data.google_compute_network.default.name
        subnetwork = data.google_compute_subnetwork.private_2.name
    }

    metadata_startup_script = file(var.PROVISIONER_SCRIPT_PATH)

    lifecycle {
        create_before_destroy = true
    }
}

resource "google_compute_region_instance_group_manager" "onebank_instance_group_2" {
    name = "onebank-instance-group-manager-2"
    base_instance_name = "onebank-backend-group-2"
    target_size = var.INSTANCE_COUNT
    region = data.google_compute_subnetwork.private_2.region

    named_port {
        name = "http"
        port = 80
    }

    version {
        name = "primary"
        instance_template = google_compute_instance_template.backend_template_2.self_link
    }

    all_instances_config {
        labels = local.common_tags
    }

    auto_healing_policies {
        health_check = google_compute_health_check.autohealing.id
        initial_delay_sec = 120
    }
}

resource "google_compute_region_autoscaler" "autoscaling_2" {
    name = "onebank-backend-autoscaler-2"
    target = google_compute_region_instance_group_manager.onebank_instance_group_2.id
    region = data.google_compute_subnetwork.private_2.region

    autoscaling_policy {
        max_replicas = var.MAX_REPLICAS
        min_replicas = var.MIN_REPLICAS
        cooldown_period = 60

        cpu_utilization {
            target = 0.7
        }
    }
}