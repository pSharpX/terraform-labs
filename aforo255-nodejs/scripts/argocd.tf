resource "kubernetes_namespace" "argocd_ns" {
    metadata {
        name = "argocd"
    }

    depends_on = [ 
        digitalocean_kubernetes_cluster.k8s-cluster
     ]
}

data "http" "argocd-resource-manifest" {
    url = "https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
}

resource "local_file" "argocd-manifest" {
    content = "${data.http.argocd-resource-manifest.response_body}"
    filename = "./configs/argocd-install.yaml"
}

resource "kubectl_manifest" "argocd" {
    yaml_body = "${local_file.argocd-manifest.content}"

    depends_on = [ 
        local_file.argocd-manifest
     ]
}