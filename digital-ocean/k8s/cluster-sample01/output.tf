output "K8S_CLUSTER_ID" {
    value = digitalocean_kubernetes_cluster.k8s-cluster-sample01.id
}

output "K8S_ENDPOINT" {
    value = digitalocean_kubernetes_cluster.k8s-cluster-sample01.endpoint
}