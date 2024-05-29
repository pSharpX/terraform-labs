output "private_vm_1_internal_ip" {
    value = google_compute_instance.onebank_private_instance_1.network_interface.0.network_ip
}

output "private_vm_2_internal_ip" {
    value = google_compute_instance.onebank_private_instance_2.network_interface.0.network_ip
}