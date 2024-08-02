# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret

resource "google_secret_manager_secret" "config_file" {
    secret_id = "config_file"
    labels = local.common_tags

    replication {
        auto {}
    }
}

resource "google_secret_manager_secret_version" "config_file_v1" {
    secret = google_secret_manager_secret.config_file.id
    secret_data = filebase64(var.CONFIG_FILE)
    is_secret_data_base64 = true
    enabled = true
}
