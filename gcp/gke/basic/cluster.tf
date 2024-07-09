# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform#node-pool-management
# In Terraform, we recommend managing your node pools using the google_container_node_pool resource, separate from the google_container_cluster resource. 

resource "google_container_cluster" "onebank" {
    name = "${local.applicationId}-cluster"
    description = "K8s Cluster for OneBank application"
    location = var.ZONE
    network = data.google_compute_network.default.name
    remove_default_node_pool = false
    initial_node_count = var.NODE_COUNT
    deletion_protection = false # Only for testing purpose
    node_locations = setsubtract(data.google_compute_zones.locations.names, [var.ZONE])

    cluster_autoscaling {
        enabled = true

        resource_limits {
            resource_type = "cpu"
            minimum = "2"
            maximum = "4"
        }
        resource_limits {
            resource_type = "memory"
            minimum = "4"
            maximum = "8"
        }
    }

    node_config {
        preemptible = true
        machine_type = data.google_compute_machine_types.general_purpose_e2_standard.machine_types[0].name
        disk_size_gb = "40"
        disk_type = "pd-standard"
        labels = local.common_tags
        tags = [ "onebank" ]
    }
}
