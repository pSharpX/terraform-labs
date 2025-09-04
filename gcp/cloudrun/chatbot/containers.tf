
resource "google_cloud_run_v2_service" "chatbot_app" {
    name = local.chatbot
    description = "Medical Conversational Chatbot powered by LLM"
    location = var.REGION
    labels = local.common_tags
    ingress = "INGRESS_TRAFFIC_ALL"
    deletion_protection = false

    scaling {
        max_instance_count = 1
    }

    template {
        revision = "${local.chatbot}-v1"
        labels = local.common_tags
        execution_environment = "EXECUTION_ENVIRONMENT_GEN2"

        containers {
            name = local.chatbot
            image = "psharpx/chatbot-mediassist:latest"
            resources {
                limits = {
                    cpu = "4"
                    memory = "16Gi"
                    "nvidia.com/gpu" = "1"
                }

                startup_cpu_boost = true
            }

            ports {
                name = "http1"
                container_port = "8501"
            }

            startup_probe {
                initial_delay_seconds = 30
                failure_threshold = 3

                http_get {
                    path = "/_stcore/health"
                }
            }

            liveness_probe {
                initial_delay_seconds = 10
                failure_threshold = 3

                http_get {
                    path = "/_stcore/health"
                }
            }
        }

        node_selector {
            accelerator = "nvidia-l4"
        }

        gpu_zonal_redundancy_disabled = true
    }

    traffic {
        type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
        percent = 100
    }
}

resource "google_cloud_run_v2_service_iam_binding" "default" {
    location = google_cloud_run_v2_service.chatbot_app.location
    name = google_cloud_run_v2_service.chatbot_app.name
    role = "roles/run.invoker"
    members = [ "allUsers" ]
}