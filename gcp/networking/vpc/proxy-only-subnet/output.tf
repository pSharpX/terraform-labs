output "vpc_id" {
    value = data.google_compute_network.onebank_network.id
}

output "vpc_uri" {
    value = data.google_compute_network.onebank_network.self_link
}