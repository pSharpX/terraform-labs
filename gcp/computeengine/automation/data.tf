data "google_compute_network" "default" {
    name = "default"
}

data "google_compute_image" "debian" {
    family = "debian-12"
    project = "debian-cloud"
}

data "google_compute_image" "ubuntu" {
    family = "ubuntu-2204-lts"
    project = "ubuntu-os-cloud"
}

data "google_compute_image" "windows" {
    family = "windows-2022"
    project = "windows-cloud"
}

data "google_compute_image" "fedora" {
    family = "fedora-cloud-39"
    project = "fedora-cloud"
}

data "google_compute_image" "rhel" {
    family = "rhel-9"
    project = "rhel-cloud"
}

data "google_compute_image" "rocky" {
    family = "rocky-linux-9"
    project = "rocky-linux-cloud"
}