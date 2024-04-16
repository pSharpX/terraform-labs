resource "google_compute_instance_from_template" "debian_worker" {
    name = "${local.base_instance_name}-worker-01"
    source_instance_template = google_compute_instance_template.debian_worker.self_link_unique
    labels = local.instance_tags
}

resource "google_compute_instance_from_template" "ubuntu_worker" {
    name = "${local.base_instance_name}-worker-02"
    source_instance_template = google_compute_instance_template.ubuntu_worker.self_link_unique
    labels = local.instance_tags
}

resource "google_compute_instance_from_template" "fedora_worker" {
    name = "${local.base_instance_name}-worker-03"
    source_instance_template = google_compute_instance_template.fedora_worker.self_link_unique
    labels = local.instance_tags
}

resource "google_compute_instance_from_template" "rhel_worker" {
    name = "${local.base_instance_name}-worker-04"
    source_instance_template = google_compute_instance_template.rhel_worker.self_link_unique
    labels = local.instance_tags
}