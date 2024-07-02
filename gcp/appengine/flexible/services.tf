resource "google_app_engine_flexible_app_version" "onebank_app_v1" {
    project = data.google_project.onebank.project_id
    version_id = "v1"
    service = "default"
    runtime = "custom"
    instance_class = "F4" # AutomaticScaling: F1, F2, F4, F4_1G ManualScaling: B1, B2, B4, B8, B4_1G Defaults to F1 for AutomaticScaling and B1 for ManualScaling.
    serving_status = "SERVING" #"STOPPED"
    
    deployment {
        container {
            image = "us-central1-docker.pkg.dev/onebank-427217/onebank-test-gar/controlplane:latest"
        }
    }

    resources {
        cpu = 1
        memory_gb = 1
        disk_gb = 10
    }

    env_variables = {
        SERVER_PORT = "8080"
    }

    network {
        name = "default"
    }

    liveness_check {
        path = "/actuator/health"
        initial_delay = "400s"
    }

    readiness_check {
        path = "/actuator/health"
    }

    automatic_scaling {
        min_total_instances = 1
        max_total_instances = 4
        cool_down_period = "120s"
        cpu_utilization {
            target_utilization = 0.6
        }
    }

    noop_on_destroy = true
    service_account = google_service_account.taskmaster_sa.email
    depends_on = [ 
        google_project_iam_member.gae_api,
        google_project_iam_member.logs_writer,
        google_project_iam_member.storage_viewer,
        google_project_iam_member.registry_reader
    ]
}