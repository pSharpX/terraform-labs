# https://cloud.google.com/storage/docs/authentication
# https://cloud.google.com/storage/docs/request-endpoints

data "http" "test_emailsender_fn" {
    url = google_cloudfunctions2_function.main.url
    method = "POST"
    request_headers = {
        Authorization = "Bearer ${data.google_service_account_access_token.invoker_access_token.access_token}"
    }
    request_body = jsonencode({
        "id" = 1
        "channel" = "EMAIL"
        "type" = "TASK_CREATED"
        "user" = "your_email"
        "title" = "Learn Terraform"
        "message" = "Learn Terraform from scratch"
        "recipientName" = var.RECIPIENT_NAME
        "recipientEmail" = var.RECIPIENT_EMAIL
        "templateName" = "task-created-template"
        "vars" = {
            "task_title" = "Learn Terraform"
            "task_description" = "Learn Terraform from Scratch"
            "task_due_date" = "10/10/2025"
            "task_priority" = "Low"
        }
    })

    lifecycle {
        postcondition {
            condition = contains([202], self.status_code)
            error_message = "Status code invalid"
        }
    }

    depends_on = [ 
        time_sleep.wait_60s_for_invoker
    ]
}