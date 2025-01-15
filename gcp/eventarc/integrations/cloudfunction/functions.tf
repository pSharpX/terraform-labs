# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function
# https://cloud.google.com/eventarc/docs/reference/supported-events

resource "google_cloudfunctions2_function" "main" {
    name = local.function_name
    location = var.REGION
    description = local.function_description
    labels = local.common_tags

    build_config {
        runtime = "java17"
        entry_point = local.function_entrypoint
        docker_repository = data.google_artifact_registry_repository.onebank_repository.id

        source {
            storage_source {
                bucket = google_storage_bucket.default.name
                object = google_storage_bucket_object.source.name
            }
        }
        service_account = google_service_account.builder_sa.id
    }

    service_config {
        max_instance_count = 2
        min_instance_count = 0
        available_memory = "512M"
        available_cpu = "1"
        timeout_seconds = 60
        environment_variables = var.APP_CONFIG_PROPS
        ingress_settings = "ALLOW_ALL"
        all_traffic_on_latest_revision = true
        service_account_email = google_service_account.service_sa.email

        dynamic "secret_environment_variables" {
            for_each = google_secret_manager_secret.cf_secrets
            content {
                key = secret_environment_variables.key
                project_id = data.google_project.onebank.project_id
                secret = google_secret_manager_secret.cf_secrets[secret_environment_variables.key].secret_id
                version = "latest"
            }
        }
    }

    depends_on = [ 
        time_sleep.wait_60s_for_builder,
        time_sleep.wait_60s_for_service,
        time_sleep.wait_60s_for_eventarc_invoker
    ]
}