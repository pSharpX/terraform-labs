# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database

resource "google_sql_database" "database_1" {
    name = local.database_name
    instance = google_sql_database_instance.mysql.name
}

resource "google_sql_database" "database_2" {
    name = local.database_name
    instance = google_sql_database_instance.postgres.name
}

resource "google_sql_database" "database_3" {
    name = local.database_name
    instance = google_sql_database_instance.mssql.name
}