resource "local_file" "kube_config" {
    content = digitalocean_kubernetes_cluster.k8s-cluster-sample01.kube_config.0.raw_config
    filename = "kubeconfig.yaml"
}