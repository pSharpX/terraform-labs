# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform#node-pool-management
# In Terraform, we recommend managing your node pools using the google_container_node_pool resource, separate from the google_container_cluster resource. 

resource "google_container_cluster" "onebank" {
    name = "${local.applicationId}-cluster"
    description = "K8s Cluster for OneBank application"
    location = local.single_zone
    node_locations = local.zonal_cluster_zones
    network = data.google_compute_network.default.name
    subnetwork = data.google_compute_subnetwork.default.name
    remove_default_node_pool = false
    initial_node_count = var.NODE_COUNT
    deletion_protection = false
    networking_mode = "VPC_NATIVE"
    # https://cloud.google.com/kubernetes-engine/docs/how-to/flexible-pod-cidr
    default_max_pods_per_node = 64

    ip_allocation_policy {
        cluster_secondary_range_name = var.CLUSTER_SECONDARY_RANGE_NAME
        services_secondary_range_name = var.SERVICES_SECONDARY_RANGE_NAME
    }

    private_cluster_config {
        enable_private_nodes = true
        enable_private_endpoint = false
        master_ipv4_cidr_block = "192.168.0.0/28"
    }

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
            node_locations,
            node_config
         ]
    }
}

resource "google_container_node_pool" "primary" {
    name = "${local.applicationId}-primary-node-pool"
    cluster = google_container_cluster.onebank.name
    location = local.single_zone
    node_locations = local.zonal_cluster_zones
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
