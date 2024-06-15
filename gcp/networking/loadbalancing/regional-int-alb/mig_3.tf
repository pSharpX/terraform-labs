resource "google_compute_instance_template" "backend_template_3" {
    name = "onebank-backend-template-3"
    description = "This template is used to create backend server instances"

    tags = [ "http-server", "onebank" ]
    labels = local.common_tags

    instance_description = "Backend Server Instances"
    machine_type = data.google_compute_machine_types.general_purpose_e2_standard.machine_types[0].name
    region = data.google_compute_subnetwork.private_1.region

    disk {
        source_image = data.google_compute_image.ubuntu.self_link
        auto_delete = true
        boot = true
        disk_size_gb = 50
    }

    network_interface {
        network = data.google_compute_network.default.name
        subnetwork = data.google_compute_subnetwork.private_1.name
    }

    metadata_startup_script = file(var.PROVISIONER_SCRIPT_PATH)

    lifecycle {
        create_before_destroy = true
    }
}

resource "google_compute_region_instance_group_manager" "onebank_instance_group_3" {
    name = "onebank-instance-group-manager-3"
    base_instance_name = "onebank-backend-group-3"
    target_size = var.INSTANCE_COUNT
    region = data.google_compute_subnetwork.private_1.region

    named_port {
        name = "http"
        port = 80
    }

    version {
        name = "primary"
        instance_template = google_compute_instance_template.backend_template_3.self_link
    }

    all_instances_config {
        labels = local.common_tags
    }

    auto_healing_policies {
        health_check = google_compute_region_health_check.autohealing_1.id
        initial_delay_sec = 300
    }
}

resource "google_compute_region_autoscaler" "autoscaling_3" {
    name = "onebank-backend-autoscaler-3"
    target = google_compute_region_instance_group_manager.onebank_instance_group_3.id
    region = data.google_compute_subnetwork.private_1.region

    autoscaling_policy {
        max_replicas = var.MAX_REPLICAS
        min_replicas = var.MIN_REPLICAS
        cooldown_period = 180

        cpu_utilization {
            target = 0.7
        }
    }
}