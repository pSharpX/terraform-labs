# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function

resource "google_cloudfunctions2_function" "main" {
    name = local.function_name
    location = var.REGION
    description = "Task Manager's Function to create tasks"
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
    }

    service_config {
        max_instance_count = 2
        min_instance_count = 1
        available_memory = "512M"
        available_cpu = "1"
        timeout_seconds = 60

        environment_variables = {
          SPRING_PROFILES_ACTIVE  = "dev"
        }

        ingress_settings = "ALLOW_ALL"
        all_traffic_on_latest_revision = true
    }
}

resource "google_cloudfunctions2_function_iam_member" "cfn_allUsers" {
    location = google_cloudfunctions2_function.main.location
    cloud_function = google_cloudfunctions2_function.main.name
    role = "roles/cloudfunctions.invoker"
    member = "allUsers"
}

resource "google_cloud_run_service_iam_member" "run_allUsers" {
    location = google_cloudfunctions2_function.main.location
    service = google_cloudfunctions2_function.main.name
    role = "roles/run.invoker"
    member = "allUsers"
}