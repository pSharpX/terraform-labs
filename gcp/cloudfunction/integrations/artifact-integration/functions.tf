# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function

resource "google_cloudfunctions2_function" "main" {
    name = local.function_name
    location = var.REGION
    description = "Task Manager's Function to search tasks"
    labels = local.common_tags

    build_config {
        runtime = "java17"
        entry_point = local.function_entrypoint
        environment_variables = {
            BUILD_CONFIG_VAR = "test"
        }

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

        environment_variables = {
          ENV  = "dev"
        }

        ingress_settings = "ALLOW_ALL"
        all_traffic_on_latest_revision = true
        service_account_email = google_service_account.service_sa.email
    }

    depends_on = [ 
        google_project_iam_member.storage_object_admin_permission,
        google_project_iam_member.artifact_registry_writer_permission
    ]
}