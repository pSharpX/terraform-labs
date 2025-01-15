# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/eventarc_trigger
# https://cloud.google.com/eventarc/docs/creating-triggers-terraform#cloud-run_4

resource "google_eventarc_trigger" "default" {
    name = local.template_trigger
    location = var.REGION
    labels = local.common_tags

    matching_criteria {
        attribute = "type"
        value = "google.cloud.storage.object.v1.finalized"
    }

    matching_criteria {
        attribute = "bucket"
        value = google_storage_bucket.onebank_templates.name
    }

    destination {
        cloud_run_service {
            service = "projects/${data.google_project.onebank.project_id}/locations/${google_cloudfunctions2_function.main.location}/services/${local.function_name}"
            region = google_cloudfunctions2_function.main.location
        }
    }
    
    service_account = google_service_account.eventarc_invoker_sa.email
    depends_on = [ 
        google_cloudfunctions2_function.main
     ]
}