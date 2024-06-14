resource "google_compute_region_autoscaler" "autoscaling" {
    name = "onebank-backend-autoscaler"
    target = google_compute_region_instance_group_manager.onebank_instance_group.id
    region = var.REGION

    autoscaling_policy {
        max_replicas = var.MAX_REPLICAS
        min_replicas = var.MIN_REPLICAS
        cooldown_period = 60

        cpu_utilization {
            target = 0.7
        }
    }
}