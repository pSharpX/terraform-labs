# https://cloud.google.com/storage/docs/authentication
# https://cloud.google.com/storage/docs/request-endpoints

data "http" "test_createtask_fn" {
    url = google_cloudfunctions2_function.main.url
    method = "POST"
    request_body = jsonencode({
        taskTitle = "title"
        taskDescription = "description"
    })

    lifecycle {
        postcondition {
            condition = contains([201], self.status_code)
            error_message = "Status code invalid"
        }
    }

    depends_on = [
        google_cloud_run_service_iam_member.run_allUsers,
        google_cloudfunctions2_function_iam_member.cfn_allUsers
    ]
}