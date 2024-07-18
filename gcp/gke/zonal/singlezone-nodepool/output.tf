output "project_number" {
    value = data.google_project.onebank.number
}

output "organization_id" {
    value = data.google_project.onebank.org_id
}

output "node_zones" {
    value = data.google_compute_zones.locations.names
}

output "cluster_endpoint" {
    value = google_container_cluster.onebank.endpoint
}

output "cluster_version" {
    value = google_container_cluster.onebank.master_version
}

output "cluster_zone" {
    value = google_container_cluster.onebank.location
}
