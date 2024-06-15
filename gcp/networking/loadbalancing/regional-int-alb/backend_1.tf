resource "google_compute_region_health_check" "autohealing_1" {
    name = "onebank-backend-autohealing-1"
    description = "Health Check configuration for MIG autoscaling"
    region = var.REGION_SUBNET_1
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

resource "google_compute_region_backend_service" "backend_1" {
    name = "onebank-backend-groups-1"
    description = "Backend Server Groups to which traffic will be routed from LB"
    region = var.REGION_SUBNET_1
    port_name = "http"
    protocol = "HTTP"
    enable_cdn = false
    load_balancing_scheme = "INTERNAL_MANAGED"
    session_affinity = "NONE"
    timeout_sec = 30

    health_checks = [ google_compute_region_health_check.autohealing_1.id ]

    backend {
        description = "Backend Group for managed instance group 1"
        group = google_compute_region_instance_group_manager.onebank_instance_group_1.instance_group
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