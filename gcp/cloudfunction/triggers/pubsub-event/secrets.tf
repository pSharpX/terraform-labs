# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret

resource "google_secret_manager_secret" "cf_secrets" {
    for_each = var.APP_CONFIG_SECRETS
    secret_id = each.key
    labels = local.common_tags
    
    replication {
        auto {}
    }
}

resource "google_secret_manager_secret_version" "cf_secrets_value" {
    for_each = var.APP_CONFIG_SECRETS
    secret = google_secret_manager_secret.cf_secrets[each.key].id
    secret_data = each.value
    enabled = true

    depends_on = [ google_secret_manager_secret.cf_secrets ]
}
