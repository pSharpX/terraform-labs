# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database

resource "google_sql_database" "controlplane" {
    name = var.DB_NAME
    instance = google_sql_database_instance.onebank_instance.name
}