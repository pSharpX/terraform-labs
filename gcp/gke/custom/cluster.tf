# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform#node-pool-management
# In Terraform, we recommend managing your node pools using the google_container_node_pool resource, separate from the google_container_cluster resource. 

resource "google_container_cluster" "onebank" {
    name = "${local.applicationId}-cluster"
    description = "K8s Cluster for OneBank application"
    location = var.ZONE
    network = data.google_compute_network.default.name
    # We can't create a cluster with no node pool defined, but we want to only use
    # separately managed node pools. So we create the smallest possible default
    # node pool and immediately delete it.
    remove_default_node_pool = true
    initial_node_count = 1
    deletion_protection = false # Only for testing purpose

    workload_identity_config {
        workload_pool = "${data.google_project.onebank.project_id}.svc.id.goog"
    }
}

resource "google_container_node_pool" "primary" {
    name = "${local.applicationId}-primary-node-pool"
    cluster = google_container_cluster.onebank.name
    location = var.ZONE
    node_count = var.NODE_COUNT

    management {
        auto_repair = true
        auto_upgrade = true
    }

    autoscaling {
        min_node_count = var.MIN_NODE_COUNT
        max_node_count = var.MAX_NODE_COUNT
    }

    node_config {
        preemptible = false
        machine_type = data.google_compute_machine_types.general_purpose_e2_standard.machine_types[0].name
        disk_size_gb = "40"
        disk_type = "pd-standard"
        image_type = "COS_CONTAINERD"
        labels = local.common_tags
        tags = [ "onebank" ]

        service_account = google_service_account.cluster_sa.email
        oauth_scopes = [ 
            "https://www.googleapis.com/auth/cloud-platform"
         ]
    }

    lifecycle {
        ignore_changes = [ 
            initial_node_count,
            node_count,
            node_locations,
            node_config,
            version
         ]
    }
}

resource "google_container_node_pool" "spot" {
    name = "${local.applicationId}-spot-node-pool"
    cluster = google_container_cluster.onebank.name
    location = var.ZONE
    node_count = var.NODE_COUNT

    management {
        auto_repair = true
        auto_upgrade = true
    }

    autoscaling {
        min_node_count = var.MIN_NODE_COUNT
        max_node_count = var.MAX_NODE_COUNT
    }

    node_config {
        preemptible = true
        machine_type = data.google_compute_machine_types.general_purpose_e2_standard.machine_types[0].name
        disk_size_gb = "20"
        disk_type = "pd-standard"
        image_type = "COS_CONTAINERD"
        labels = local.common_tags
        tags = [ "onebank" ]
        service_account = google_service_account.cluster_sa.email
        oauth_scopes = [
            "https://www.googleapis.com/auth/cloud-platform"
        ]

        taint {
            key = "instance_type"
            value = "spot"
            effect = "NO_SCHEDULE"
        }
    }

    lifecycle {
        ignore_changes = [ 
            initial_node_count,
            node_count,
            node_locations,
            node_config,
            version
         ]
    }
}