output "k8s-versions" {
  value = data.digitalocean_kubernetes_versions.kubernetes-versions.valid_versions
}

output "kubernetes_cluster" {
    value = {
        "cluster_id": digitalocean_kubernetes_cluster.k8s-cluster.id
        "cluster_endpoint": digitalocean_kubernetes_cluster.k8s-cluster.endpoint
    }
}
