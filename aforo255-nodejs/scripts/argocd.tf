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

resource "local_file" "argocd-manifest-file" {
    content = "${data.http.argocd-resource-manifest.response_body}"
    filename = "./configs/argocd-install.yaml"
}

data "kubectl_file_documents" "argocd-manifests" {
    content = file("${local_file.argocd-manifest-file.filename}")

    depends_on = [ 
        local_file.argocd-manifest-file
     ]
}

resource "kubectl_manifest" "argocd" {
    for_each  = data.kubectl_file_documents.argocd-manifests.manifests
    yaml_body = each.value
    override_namespace = "${kubernetes_namespace.argocd_ns.metadata[0].name}"

    depends_on = [ 
        local_file.argocd-manifest-file
     ]
}