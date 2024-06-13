resource "google_compute_url_map" "backend_map" {
    name = "onebank-lb-urlmap"
    description = "The main URL Map for LB routing traffic to backend groups servers"
    default_service = google_compute_backend_service.backend_1.id

    host_rule {
        hosts = [ "*" ]
        path_matcher = "allpaths"
    }

    host_rule {
        hosts = [ "anyothersite.com" ]
        path_matcher = "anyothersite"
    }

    path_matcher {
        name = "allpaths"
        description = "Path rules for all  expected clients"
        default_service = google_compute_backend_service.backend_1.id

        path_rule {
            paths = [ "/backend-one/*" ]
            service = google_compute_backend_service.backend_1.id
        }

        path_rule {
            paths = [ "/backend-two/*" ]
            service = google_compute_backend_service.backend_2.id
        }

        path_rule {
            paths = [ "/backend-three/*" ]
            service = google_compute_backend_service.backend_3.id
        }

        path_rule {
            paths = [ "/*" ]
            service = google_compute_backend_service.backend_2.id
        }
    }

    path_matcher {
        name = "anyothersite"
        description = "Path rules for all unknown clients"
        default_service = google_compute_backend_service.backend_1.id

        path_rule {
            paths = [ "/unknown-one" ]
            service = google_compute_backend_service.backend_1.id
        }
    }

}

resource "google_compute_global_address" "alb_ip" {
    name = "onebank-alb-ip"
    description = "External IP Address for ALB"
    address_type = "EXTERNAL"
    ip_version = "IPV4"
}

resource "google_compute_target_http_proxy" "default" {
    name = "onebank-target-proxy"
    url_map = google_compute_url_map.backend_map.id
}

resource "google_compute_global_forwarding_rule" "default" {
    name = "l7-xlb-forwarding-rule"
    ip_protocol = "TCP"
    load_balancing_scheme = "EXTERNAL"
    port_range = "80"
    target = google_compute_target_http_proxy.default.id
    ip_address = google_compute_global_address.alb_ip.id
}