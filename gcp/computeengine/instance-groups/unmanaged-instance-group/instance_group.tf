resource "google_compute_instance_group" "onebank_instance_group" {
    name = local.instance_group_name
    description = "Backend servers for onebank platform"
    network = data.google_compute_network.default.id

    instances = [
        google_compute_instance_from_template.debian_worker.id,
        google_compute_instance_from_template.ubuntu_worker.id,
        google_compute_instance_from_template.fedora_worker.id,
        google_compute_instance_from_template.rhel_worker.id
    ]

    named_port {
        name = "http"
        port = 80
    }

    lifecycle {
        create_before_destroy = true
    }
}