output "project_number" {
    value = data.google_project.onebank.number
}

output "db_password_secret_id" {
    value = google_secret_manager_secret.db_password.id
}

output "db_password_secret_v1" {
    value = google_secret_manager_secret_version.db_password_v1.id
}

output "db_password_secret_value_successful" {
  value = jsondecode(data.http.secret_test_case_successful.response_body)["payload"]["data"]
}

output "db_password_secret_value_failed" {
  value = jsondecode(data.http.secret_test_case_failed.response_body)
}
