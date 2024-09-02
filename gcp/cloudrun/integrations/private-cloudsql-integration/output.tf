output "project_number" {
    value = data.google_project.onebank.number
}

output "organization_id" {
    value = data.google_project.onebank.org_id
}

output "default_repository_url" {
    value = local.repository_url
}

output "service_id" {
    value = google_cloud_run_v2_service.onebank_app.id
}

output "service_url" {
    value = google_cloud_run_v2_service.onebank_app.uri
}


output "db_info" {
    value = {
        ip = google_sql_database_instance.onebank_instance.ip_address.0.ip_address
        public_ip = google_sql_database_instance.onebank_instance.public_ip_address
        private_ip = google_sql_database_instance.onebank_instance.private_ip_address
        connection_name = google_sql_database_instance.onebank_instance.connection_name
        database = google_sql_database.controlplane.name
        username = google_sql_user.admin.name
    }
    sensitive = true
}