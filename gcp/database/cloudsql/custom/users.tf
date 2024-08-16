# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user

resource "google_sql_user" "admin_1" {
    name = var.DB_USER
    instance = google_sql_database_instance.mysql.name
    # Host field is only supported for MySQL instances
    host = "%" 
    password = var.DB_PASSWORD
}

resource "google_sql_user" "admin_2" {
    name = var.DB_USER
    instance = google_sql_database_instance.postgres.name
    password = var.DB_PASSWORD
}

resource "google_sql_user" "admin_3" {
    name = var.DB_USER
    instance = google_sql_database_instance.mssql.name
    password = var.DB_PASSWORD
}