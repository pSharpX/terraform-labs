# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret

resource "google_secret_manager_secret" "db_password" {
    secret_id = "db_password"
    labels = local.common_tags

    replication {
        auto {}
    }
}

resource "google_secret_manager_secret_version" "db_password_v1" {
    secret = google_secret_manager_secret.db_password.id
    secret_data = var.DB_PASSWORD
    enabled = true
}
