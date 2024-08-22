output "project_number" {
    value = data.google_project.onebank.number
}

output "mysql_credentials" {
    value = {
        ip = google_sql_database_instance.instance_1.ip_address.0.ip_address
        connection_name = google_sql_database_instance.instance_1.connection_name
        database = google_sql_database.database_1.name
        username = google_sql_user.user_1.name
        iam_username = google_sql_user.iam_user_1.name
    }
}

output "pgsql_credentials" {
    value = {
        ip = google_sql_database_instance.instance_2.ip_address.0.ip_address
        connection_name = google_sql_database_instance.instance_2.connection_name
        database = google_sql_database.database_2.name
        username = google_sql_user.user_2.name
        iam_username = google_sql_user.iam_user_2.name
    }
}

output "temp_pwd" {
    value = data.google_service_account_access_token.sql_sa_access_token.access_token
    sensitive = true
}