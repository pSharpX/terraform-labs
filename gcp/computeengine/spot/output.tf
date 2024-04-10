output "instance-ip" {
    value = google_compute_instance.onebank_instance.network_interface.0.access_config.0.nat_ip
}

output "ssh" {
    value = "ssh -i ./ssh/ec2-keypair ${var.USERNAME}@${google_compute_instance.onebank_instance.network_interface.0.access_config.0.nat_ip}"
}