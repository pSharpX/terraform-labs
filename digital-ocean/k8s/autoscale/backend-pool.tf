resource "digitalocean_kubernetes_node_pool" "backend-pool" {
    cluster_id = digitalocean_kubernetes_cluster.k8s-cluster-autoscale.id
    name = "autoscale-backend-pool"
    size = lookup(var.DO_DROPLET_SIZES, var.DO_DROPLET_DEFAULT_SIZE)
    auto_scale = true
    min_nodes = 1
    max_nodes = 3
    tags = [ "terraform", "backend", "test", "autoscale" ]
    
    labels = {
      service: "backend"
      priority: "high"
    }
}