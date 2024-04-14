output "instance-ip" {
    value = [for server in google_compute_instance_from_template.onebank_instances: server.network_interface.0.access_config.0.nat_ip]
}

output "image" {
    value = data.google_compute_image.ubuntu.name
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