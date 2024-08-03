data "http" "secret_test_case_successful" {
    url = "https://secretmanager.googleapis.com/v1/projects/${data.google_project.onebank.project_id}/secrets/${google_secret_manager_secret.db_password.secret_id}/versions/latest:access"
    request_headers = {
        Authorization = "Bearer ${data.google_service_account_access_token.secret_specific_sa_access_token.access_token}"
    }

    lifecycle {
        postcondition {
            condition = contains([200], self.status_code)
            error_message = "Status code invalid"
        }
    }
}


data "http" "secret_test_case_failed" {
    url = "https://secretmanager.googleapis.com/v1/projects/${data.google_project.onebank.project_id}/secrets/${google_secret_manager_secret.db_password.secret_id}/versions/latest:access"
    request_headers = {
        Authorization = "Bearer ${data.google_service_account_access_token.secret_viewer_sa_access_token.access_token}"
    }

    lifecycle {
        postcondition {
            condition = contains([403], self.status_code)
            error_message = "Status code invalid"
        }
    }
}
