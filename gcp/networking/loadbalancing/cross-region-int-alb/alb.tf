resource "google_compute_url_map" "backend_map" {
    name = "onebank-xlb-urlmap"
    description = "The main URL Map for LB routing traffic to backend servers groups"
    default_service = google_compute_backend_service.backend.id

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
        description = "Path rules for all  expected known clients"
        default_service = google_compute_backend_service.backend.id

        path_rule {
            paths = [ "/backend-one/*" ]
            service = google_compute_backend_service.backend.id
        }

        path_rule {
            paths = [ "/*" ]
            service = google_compute_backend_service.backend.id
        }
    }

    path_matcher {
        name = "anyothersite"
        description = "Path rules for all unknown clients"
        default_service = google_compute_backend_service.backend.id

        path_rule {
            paths = [ "/unknown-one" ]
            service = google_compute_backend_service.backend.id
        }
    }
}

resource "google_compute_target_http_proxy" "default" {
    name = "onebank-target-proxy"
    url_map = google_compute_url_map.backend_map.id
}

resource "google_compute_global_forwarding_rule" "fwd_rule_1" {
    name = "gil7forwarding-rule-1"
    ip_protocol = "TCP"
    load_balancing_scheme = "INTERNAL_MANAGED"
    port_range = "80"
    target = google_compute_target_http_proxy.default.id
    network = data.google_compute_network.default.id
    subnetwork = data.google_compute_subnetwork.private_1.id
}

resource "google_compute_global_forwarding_rule" "fwd_rule_2" {
    name = "gil7forwarding-rule-2"
    ip_protocol = "TCP"
    load_balancing_scheme = "INTERNAL_MANAGED"
    port_range = "80"
    target = google_compute_target_http_proxy.default.id
    network = data.google_compute_network.default.id
    subnetwork = data.google_compute_subnetwork.private_2.id
}