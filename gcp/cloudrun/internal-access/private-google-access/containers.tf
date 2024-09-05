
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service
# https://cloud.google.com/run/docs/securing/private-networking

resource "google_cloud_run_v2_service" "onebank_app" {
    name = local.control_plane
    description = "Onebank ControlPlane exposes TaskMaster's resources and works as orchestrator between multiple components"
    location = var.REGION
    labels = local.common_tags
    ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"

    template {
        revision = local.control_plane_last_revision
        labels = local.common_tags
        execution_environment = "EXECUTION_ENVIRONMENT_GEN2"

        scaling {
            min_instance_count = 1
            max_instance_count = 1
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
        }

        service_account = google_service_account.default.email
    }

    traffic {
        type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
        percent = 100
    }
}
