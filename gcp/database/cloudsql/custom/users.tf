# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user

resource "google_sql_user" "admin" {
    name = var.DB_USER
    instance = google_sql_database_instance.mysql.name
    host = "%" # Host field is only supported for MySQL instances: POSTGRES_15
    password = var.DB_PASSWORD
}