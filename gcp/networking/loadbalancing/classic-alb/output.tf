output "mig_1" {
    value = google_compute_instance_group_manager.onebank_instance_group_1.self_link
}

output "backend_1" {
    value = google_compute_backend_service.backend_1.self_link
}

output "mig_2" {
    value = google_compute_instance_group_manager.onebank_instance_group_2.self_link
}

output "backend_2" {
    value = google_compute_backend_service.backend_2.self_link
}

output "mig_3" {
    value = google_compute_instance_group_manager.onebank_instance_group_3.self_link
}

output "backend_3" {
    value = google_compute_backend_service.backend_3.self_link
}

output "alb_ip_address" {
    value = google_compute_global_address.alb_ip.address
}