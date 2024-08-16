# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database

resource "google_sql_database" "onebank" {
    name = local.database_name
    instance = google_sql_database_instance.mysql.name
}