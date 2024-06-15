output "mig_1" {
    value = google_compute_region_instance_group_manager.onebank_instance_group_1.self_link
}

output "mig_2" {
    value = google_compute_region_instance_group_manager.onebank_instance_group_2.self_link
}

output "mig_3" {
    value = google_compute_region_instance_group_manager.onebank_instance_group_3.self_link
}

output "backend_1" {
    value = google_compute_region_backend_service.backend_1.self_link
}

output "backend_2" {
    value = google_compute_region_backend_service.backend_2.self_link
}

output "fwd_rule_1_ip_address" {
    value = google_compute_forwarding_rule.fwd_rule_1.ip_address
}

output "fwd_rule_2_ip_address" {
    value = google_compute_forwarding_rule.fwd_rule_2.ip_address
}