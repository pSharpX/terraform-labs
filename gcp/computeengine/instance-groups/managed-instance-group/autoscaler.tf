resource "google_compute_autoscaler" "autoscaling" {
    name = "onebank-backend-autoscaler"
    target = google_compute_instance_group_manager.onebank_instance_group.id

    autoscaling_policy {
        max_replicas = var.MAX_REPLICAS
        min_replicas = var.MIN_REPLICAS
        cooldown_period = 60

        cpu_utilization {
            target = 0.7
        }
    }
}