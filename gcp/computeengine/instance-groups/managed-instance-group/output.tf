output "image" {
    value = data.google_compute_image.ubuntu.name
}

output "machine_types" {
    value = [for mt in data.google_compute_machine_types.general_purpose_e2_standard.machine_types: mt.name]
}