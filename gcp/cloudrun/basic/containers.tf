
resource "google_cloud_run_v2_service" "onebank_app" {
    name = local.control_plane
    description = "Onebank ControlPlane exposes TaskMaster's resources and works as orchestrator between multiple components"
    location = var.REGION
    labels = local.common_tags
    ingress = "INGRESS_TRAFFIC_ALL"

    template {
        revision = "${local.control_plane}-v1"
        labels = local.common_tags
        execution_environment = "EXECUTION_ENVIRONMENT_GEN1"

        scaling {
            min_instance_count = 1
            max_instance_count = 5
        }

        containers {
            name = local.control_plane
            image = "us-central1-docker.pkg.dev/onebank-427217/onebank-docker/controlplane:latest"
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

            env {
                name = "SPRING_PROFILES_ACTIVE"
                value = "dev"
            }
        }
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