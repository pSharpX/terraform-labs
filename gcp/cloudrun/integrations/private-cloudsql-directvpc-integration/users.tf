# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user

resource "google_sql_user" "admin" {
    name = var.DB_USER
    instance = google_sql_database_instance.onebank_instance.name
    password = var.DB_PASSWORD
}