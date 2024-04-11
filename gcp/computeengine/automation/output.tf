output "instance-ip" {
    value = google_compute_instance.onebank_instance.network_interface.0.access_config.0.nat_ip
}

output "general_purpose_n1_standard_1" {
    value = data.google_compute_machine_types.n1_standard_1.machine_types[0].name
}

output "general_purpose_n4_standard" {
    value = [for mt in data.google_compute_machine_types.general_purpose_n4_standard.machine_types: mt.name]
}

output "general_purpose_n4_standard_highcpu" {
    value = [for mt in data.google_compute_machine_types.general_purpose_n4_standard_highcpu.machine_types: mt.name]
}

output "general_purpose_n4_standard_highmem" {
    value = [for mt in data.google_compute_machine_types.general_purpose_n4_standard_highmem.machine_types: mt.name]
}

output "general_purpose_n1_standard" {
    value = [for mt in data.google_compute_machine_types.general_purpose_n1_standard.machine_types: mt.name]
}

output "general_purpose_n1_standard_highcpu" {
    value = [for mt in data.google_compute_machine_types.general_purpose_n1_standard_highcpu.machine_types: mt.name]
}

output "general_purpose_n1_standard_highmem" {
    value = [for mt in data.google_compute_machine_types.general_purpose_n1_standard_highmem.machine_types: mt.name]
}

output "general_purpose_e2_standard" {
    value = [for mt in data.google_compute_machine_types.general_purpose_e2_standard.machine_types: mt.name]
}

output "general_purpose_e2_standard_highcpu" {
    value = [for mt in data.google_compute_machine_types.general_purpose_e2_standard_highcpu.machine_types: mt.name]
}

output "general_purpose_e2_standard_highmem" {
    value = [for mt in data.google_compute_machine_types.general_purpose_e2_standard_highmem.machine_types: mt.name]
}