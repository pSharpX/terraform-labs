output "kubernetes_cluster" {
    value = {
        "cluster_id": digitalocean_kubernetes_cluster.k8s-cluster.id
        "cluster_endpoint": digitalocean_kubernetes_cluster.k8s-cluster.endpoint
    }
}
