resource "google_compute_backend_service" "backend" {
    name = "onebank-backend-groups"
    description = "Backend Server Groups to which traffic will be routed from LB"
    port_name = "http"
    protocol = "HTTP"
    enable_cdn = false
    load_balancing_scheme = "INTERNAL_MANAGED"
    session_affinity = "NONE"
    timeout_sec = 30

    health_checks = [ google_compute_health_check.autohealing.id ]

    backend {
        description = "Backend Group for managed instance group 1"
        group = google_compute_region_instance_group_manager.onebank_instance_group_1.instance_group
        balancing_mode = "UTILIZATION"
        capacity_scaler = 1.0
    }

    backend {
        description = "Backend Group for managed instance group 2"
        group = google_compute_region_instance_group_manager.onebank_instance_group_2.instance_group
        balancing_mode = "UTILIZATION"
        capacity_scaler = 1.0
    }

    backend {
        description = "Backend Group for managed instance group 3"
        group = google_compute_region_instance_group_manager.onebank_instance_group_3.instance_group
        balancing_mode = "UTILIZATION"
        capacity_scaler = 1.0
    }

    log_config {
        enable = true
    }
}