output "project_number" {
    value = data.google_project.onebank.number
}

output "hostname" {
    value = google_redis_instance.default.host
}

output "port" {
    value = google_redis_instance.default.port
}

output "read_endpoint" {
    value = google_redis_instance.default.read_endpoint
}

output "read_endpoint_port" {
    value = google_redis_instance.default.read_endpoint_port
}
