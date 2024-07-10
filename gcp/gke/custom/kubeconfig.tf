data "template_file" "kubeconfig" {
    template = file("./templates/kubeconfig.tmpl")

    vars = {
        name = google_container_cluster.onebank.name
        endpoint = "https://${google_container_cluster.onebank.endpoint}"
        cluster_ca_certificate = google_container_cluster.onebank.master_auth[0].cluster_ca_certificate
        access_token = data.google_client_config.default.access_token
    }
}

resource "local_file" "kubeconfig" {
    content = data.template_file.kubeconfig.rendered
    filename = "./configs/kubeconfig.yaml"
}