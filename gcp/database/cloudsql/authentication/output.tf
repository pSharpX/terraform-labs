output "project_number" {
    value = data.google_project.onebank.number
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

output "db_user" {
    value = google_sql_user.iam_sa_user.name
}

output "temp_pwd" {
    value = data.google_service_account_access_token.sql_sa_access_token.access_token
    sensitive = true
}