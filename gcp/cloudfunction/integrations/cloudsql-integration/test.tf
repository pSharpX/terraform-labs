# https://cloud.google.com/storage/docs/authentication
# https://cloud.google.com/storage/docs/request-endpoints

data "http" "test_createtask_fn" {
    url = google_cloudfunctions2_function.main.url
    method = "POST"
    request_body = jsonencode({
        taskTitle = "title"
    })

    lifecycle {
        postcondition {
            condition = contains([201], self.status_code)
            error_message = "Status code invalid"
        }
    }
}