resource "google_container_cluster" "onebank" {
    name = "${local.applicationId}-cluster"
    description = "K8s Cluster for OneBank application"
    location = var.ZONE
    network = data.google_compute_network.default.name
    remove_default_node_pool = true
    initial_node_count = 1
    deletion_protection = false # Only for testing purpose
}

resource "google_container_node_pool" "primary" {
    name = "${local.applicationId}-primary-node-pool"
    cluster = google_container_cluster.onebank.name
    location = var.ZONE
    node_count = var.NODE_COUNT
    node_locations = slice(data.google_compute_zones.locations.names, 0, 2)

    management {
        auto_repair = true
        auto_upgrade = true
    }

    node_config {
        preemptible = false
        machine_type = data.google_compute_machine_types.general_purpose_e2_standard.machine_types[0].name
        disk_size_gb = "40"
        disk_type = "pd-standard"
        labels = local.common_tags
    }
}