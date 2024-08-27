
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
            max_instance_count = 3
        }

        volumes {
            name = "cloudsql"
            cloud_sql_instance {
                instances = [ google_sql_database_instance.onebank_instance.connection_name ]
            }
        }

        volumes {
            name = "certificates_bucket"
            gcs {
                bucket = google_storage_bucket.default.name
                read_only = true
            }
        }

        containers {
            name = local.control_plane
            image = "${local.repository_url}/psharpx/controlplane:12"
            resources {
                limits = {
                    cpu = "2"
                    memory = "1024Mi"
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

            # env {
            #     name = "SPRING_PROFILES_ACTIVE"
            #     value = "dev"
            # }
            # env {
            #     name = "CONTROL_PLANE_DATABASE_ENABLED"
            #     value = "true"
            # }
            # env {
            #     name = "SPRING_DATASOURCE_DRIVER_CLASS_NAME"
            #     value = "org.postgresql.Driver"
            # }
            # env {
            #     name = "SPRING_JPA_HIBERNATE_DDL_AUTO"
            #     value = "update"
            # }

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

            volume_mounts {
                name = "cloudsql"
                mount_path = "/cloudsql"
            }

            volume_mounts {
                name = "certificates_bucket"
                mount_path = "/truststore"
            }
        }

        service_account = google_service_account.default.email
    }

    traffic {
        type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
        percent = 100
    }

    depends_on = [ 
        google_sql_database_instance.onebank_instance,
        google_storage_bucket.default,
        google_storage_bucket_object.truststore_dir
    ]
}

resource "google_cloud_run_v2_service_iam_binding" "default" {
    location = google_cloud_run_v2_service.onebank_app.location
    name = google_cloud_run_v2_service.onebank_app.name
    role = "roles/run.invoker"
    members = [ "allUsers" ]
}