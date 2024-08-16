output "project_number" {
    value = data.google_project.onebank.number
}

output "database_instance_mysql" {
    value = google_sql_database_instance.mysql.ip_address.0.ip_address
}

output "database_instance_postgres" {
    value = google_sql_database_instance.postgres.ip_address.0.ip_address
}

output "database_instance_mssql" {
    value = google_sql_database_instance.mssql.ip_address.0.ip_address
}
