resource "google_compute_http_health_check" "http" {
    name = "onebank-workers-healthcheck"
    description = "Health Check configuration for Backend Worker Instances"
    request_path = "/"
    port = 80
    check_interval_sec = 5
    timeout_sec = 5
    healthy_threshold = 2
    unhealthy_threshold = 5
}