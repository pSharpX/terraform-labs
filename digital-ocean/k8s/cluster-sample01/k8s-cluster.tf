resource "digitalocean_kubernetes_cluster" "k8s-cluster-sample01" {
    name = "k8s-cluster-sample01"
    region = lookup(var.DO_REGIONS, var.DO_DEFAULT_REGION)
    version = lookup(var.DO_K8S_VERSIONS, "latest")
    tags = [ "terraform", "cluster", "test" ]

    node_pool {
        name = "worker-pool"
        size = lookup(var.DO_DROPLET_SIZES, var.DO_DROPLET_DEFAULT_SIZE)
        node_count = 3
        tags = [ "terraform", "test", "worker" ]
    }
}