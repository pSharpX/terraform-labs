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

data "google_compute_machine_types" "n1_standard_1" {
    filter = "name = n1-standard-1"
    zone = var.ZONE
}

# N4 machine types (https://cloud.google.com/compute/docs/general-purpose-machines#n4_machine_types)
# standard: 4 GB memory per vCPU
# highcpu: 2 GB memory per vCPU
# highmem: 8 GB memory per vCPU

data "google_compute_machine_types" "general_purpose_n4_standard" {
    filter = "name = n4-standard* AND guestCpus >= 2 AND guestCpus <= 4 AND memoryMb >= 4096 AND memoryMb <= 16384"
    zone = var.ZONE
}

data "google_compute_machine_types" "general_purpose_n4_standard_highcpu" {
    filter = "name = n4-highcpu* AND guestCpus >= 2 AND guestCpus <= 4"
    zone = var.ZONE
}

data "google_compute_machine_types" "general_purpose_n4_standard_highmem" {
    filter = "name = n4-highmem* AND memoryMb >= 8192 AND memoryMb <= 16384"
    zone = var.ZONE
}

# N1 machine series (https://cloud.google.com/compute/docs/general-purpose-machines#n1_machines)
# N1 standard machine types have 3.75 GB of system memory per vCPU.
# N1 high-memory machine types have 6.5 GB of system memory per vCPU.
# N1 high-cpu machine types have 0.9 GB of system memory per vCPU. High-CPU machine types are ideal for tasks that require a moderate increase of vCPUs relative to memory.

data "google_compute_machine_types" "general_purpose_n1_standard" {
    filter = "name = n1-standard* AND guestCpus >= 2 AND guestCpus <= 4 AND memoryMb >= 4096 AND memoryMb <= 8192"
    zone = var.ZONE
}

data "google_compute_machine_types" "general_purpose_n1_standard_highcpu" {
    filter = "name = n1-highcpu* AND guestCpus >= 2 AND guestCpus <= 4"
    zone = var.ZONE
}

data "google_compute_machine_types" "general_purpose_n1_standard_highmem" {
    filter = "name = n1-highmem* AND memoryMb >= 8192 AND memoryMb <= 16384"
    zone = var.ZONE
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
