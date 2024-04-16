resource "google_compute_backend_service" "backend" {
    name = "onebank-worker-loadbalancer"
    description = "Backend Workers will server traffic for LB"
    port_name = "http"
    protocol = "HTTP"
    compression_mode = "AUTOMATIC"
    enable_cdn = true
    load_balancing_scheme = "EXTERNAL"
    session_affinity = "NONE"
    timeout_sec = 30

    backend {
        group = google_compute_instance_group.onebank_instance_group.id
    }

    health_checks = [
        google_compute_http_health_check.http.id
    ]

    log_config {
        enable = true
    }
}