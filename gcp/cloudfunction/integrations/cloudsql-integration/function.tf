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
            SPRING_PROFILES_ACTIVE = "dev"
            CONTROL_PLANE_DATABASE_ENABLED = "true"
            SPRING_DATASOURCE_DRIVER_CLASS_NAME = "org.postgresql.Driver"
            SPRING_JPA_HIBERNATE_DDL_AUTO = "update"
            SPRING_DATASOURCE_USERNAME = var.DB_USER
            SPRING_DATASOURCE_PASSWORD = var.DB_PASSWORD
            SPRING_DATASOURCE_URL = "jdbc:postgresql://${google_sql_database_instance.onebank_instance.ip_address.0.ip_address}:5432/${var.DB_NAME}"
        }
        ingress_settings = "ALLOW_ALL"
        all_traffic_on_latest_revision = true
        vpc_connector_egress_settings = "ALL_TRAFFIC"
        vpc_connector = google_vpc_access_connector.vpc_connector.name
        service_account_email = google_service_account.service_sa.email
    }

    depends_on = [ google_sql_database.controlplane ]
}
