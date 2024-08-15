output "project_number" {
    value = data.google_project.onebank.number
}

output "db_instance_id" {
    value = google_sql_database_instance.db_instance.id
}

output "db_instance_ip" {
    value = google_sql_database_instance.db_instance.ip_address.0.ip_address
}

output "db_instance_connection_name" {
    value = google_sql_database_instance.db_instance.connection_name
}

output "db_name" {
    value = google_sql_database.onebank.name
}