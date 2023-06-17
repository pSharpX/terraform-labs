resource "digitalocean_kubernetes_cluster" "k8s-cluster" {
    name = "k8s-cluster"
    region = lookup(var.DO_REGIONS, var.DO_DEFAULT_REGION)
    version = lookup(var.DO_K8S_VERSIONS, "latest")
    tags = [ "terraform", "cluster", "test" ]

    node_pool {
        name = "k8s-master-pool"
        size = lookup(var.DO_DROPLET_SIZES, var.DO_DROPLET_DEFAULT_SIZE)
        node_count = 1
        tags = [ "terraform", "test", "master", "fixed" ]
    }
}

resource "digitalocean_kubernetes_node_pool" "k8s-worker-pool" {
    cluster_id = digitalocean_kubernetes_cluster.k8s-cluster.id
    name = "k8s-worker-pool"
    size = lookup(var.DO_DROPLET_SIZES, var.DO_DROPLET_DEFAULT_SIZE)
    auto_scale = true
    min_nodes = 1
    max_nodes = 2
    tags = [ "terraform", "test", "worker", "autoscale" ]
}