resource "google_compute_region_health_check" "autohealing_2" {
    name = "onebank-backend-autohealing-2"
    description = "Health Check configuration for MIG autoscaling"
    region = var.REGION_SUBNET_2
    check_interval_sec = 5
    timeout_sec = 5
    healthy_threshold = 2
    unhealthy_threshold = 5

    http_health_check {
        request_path = "/"
        port = 80
    }

    log_config {
        enable = false
    }
}

resource "google_compute_region_backend_service" "backend_2" {
    name = "onebank-backend-groups-2"
    description = "Backend Server Groups to which traffic will be routed from LB"
    region = var.REGION_SUBNET_2
    port_name = "http"
    protocol = "HTTP"
    enable_cdn = false
    load_balancing_scheme = "INTERNAL_MANAGED"
    session_affinity = "NONE"
    timeout_sec = 30

    health_checks = [ google_compute_region_health_check.autohealing_2.id ]

    backend {
        description = "Backend Group for managed instance group 2"
        group = google_compute_region_instance_group_manager.onebank_instance_group_2.instance_group
        balancing_mode = "UTILIZATION"
        capacity_scaler = 1.0
    }

    log_config {
        enable = true
    }
}