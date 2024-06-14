resource "google_compute_health_check" "autohealing" {
    name = "onebank-backend-autohealing"
    description = "Health Check configuration for MIG autoscaling"
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