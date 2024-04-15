resource "google_compute_instance_group_manager" "onebank_instance_group" {
    name = local.instance_group_name
    base_instance_name = "onebank-backend"
    target_size = var.INSTANCE_COUNT

    version {
        instance_template = google_compute_instance_template.backend.self_link_unique
    }

    all_instances_config {
        labels = local.common_tags
    }

    auto_healing_policies {
        health_check = google_compute_health_check.autohealing.id
        initial_delay_sec = 120
    }
}