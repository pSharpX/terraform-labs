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
    #filter = "name:ubuntu* AND NOT name:arm64"
    #filter = "(name eq ubuntu.*-v2024.*) AND (name ne .*arm64*)"# AND deprecated.state != DEPRECATED"
    # filter = "name eq ubuntu.*-v2024.* AND deprecated.state != DEPRECATED"
    most_recent = true
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

# E2 machine types (https://cloud.google.com/compute/docs/general-purpose-machines#e2_machine_types_table)
# E2 standard machine types have 4 GB of system memory per vCPU.
# E2 high-memory machine types have 8 GB of system memory per vCPU.
# E2 high-cpu machine types have 1 GB of system memory per vCPU.

data "google_compute_machine_types" "general_purpose_e2_standard" {
    filter = "name = e2-standard* AND guestCpus >= 2 AND guestCpus <= 4 AND memoryMb >= 4096 AND memoryMb <= 8192"
    zone = var.ZONE
}

data "google_compute_machine_types" "general_purpose_e2_standard_highcpu" {
    filter = "name = e2-highcpu* AND guestCpus >= 2 AND guestCpus <= 4"
    zone = var.ZONE
}

data "google_compute_machine_types" "general_purpose_e2_standard_highmem" {
    filter = "name = e2-highmem* AND memoryMb >= 8192 AND memoryMb <= 16384"
    zone = var.ZONE
}
