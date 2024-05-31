output "vpc_id" {
    value = google_compute_network.onebank_network.id
}

output "vpc_uri" {
    value = google_compute_network.onebank_network.self_link
}