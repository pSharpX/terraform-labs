# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret

resource "google_secret_manager_secret" "configs" {
    for_each = var.APP_CONFIGURATIONS
    secret_id = each.key
    labels = local.common_tags

    replication {
        auto {}
    }
}

resource "google_secret_manager_secret_version" "configs_version" {
    for_each = google_secret_manager_secret.configs
    secret = each.value.id
    secret_data = lookup(var.APP_CONFIGURATIONS, each.value.secret_id)
    enabled = true
}