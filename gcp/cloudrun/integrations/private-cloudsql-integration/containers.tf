
resource "google_cloud_run_v2_service" "onebank_app" {
    name = local.control_plane
    description = "Onebank ControlPlane exposes TaskMaster's resources and works as orchestrator between multiple components"
    location = var.REGION
    labels = local.common_tags
    ingress = "INGRESS_TRAFFIC_ALL"

    template {
        revision = local.control_plane_last_revision
        labels = local.common_tags
        execution_environment = "EXECUTION_ENVIRONMENT_GEN2"

        scaling {
            min_instance_count = 1
            max_instance_count = 2
        }

        containers {
            name = local.control_plane
            image = "${local.repository_url}/psharpx/controlplane:12"
            resources {
                limits = {
                    cpu = "1"
                    memory = "512Mi"
                }

                cpu_idle = true
            }

            ports {
                name = "http1"
                container_port = "8080"
            }

            startup_probe {
                initial_delay_seconds = 30
                failure_threshold = 3

                http_get {
                    path = "/actuator/health"
                }
            }

            liveness_probe {
                initial_delay_seconds = 10
                failure_threshold = 3

                http_get {
                    path = "/actuator/health"
                }
            }

            dynamic "env" {
                for_each = var.APP_CONFIGURATIONS
                content {
                    name = env.key
                    value = env.value
                }
            }
            env {
                name = "SPRING_DATASOURCE_USERNAME"
                value_source {
                    secret_key_ref {
                        secret = google_secret_manager_secret.db_user.secret_id
                        version = "1"
                    }
                }
            }
            env {
                name = "SPRING_DATASOURCE_PASSWORD"
                value_source {
                    secret_key_ref {
                        secret = google_secret_manager_secret.db_password.secret_id
                        version = "1"
                    }
                }
            }
            env {
                name = "SPRING_DATASOURCE_URL"
                value_source {
                    secret_key_ref {
                        secret = google_secret_manager_secret.datasource_url.secret_id
                        version = "1"
                    }
                }
            }
        }

        vpc_access {
            connector = google_vpc_access_connector.default.id
            egress = "ALL_TRAFFIC"
        }

        service_account = google_service_account.default.email
    }

    traffic {
        type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
        percent = 100
    }
}

resource "google_cloud_run_v2_service_iam_binding" "default" {
    location = google_cloud_run_v2_service.onebank_app.location
    name = google_cloud_run_v2_service.onebank_app.name
    role = "roles/run.invoker"
    members = [ "allUsers" ]
}