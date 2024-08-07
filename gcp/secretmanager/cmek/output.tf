output "project_number" {
    value = data.google_project.onebank.number
}

output "db_password_secret_id" {
    value = google_secret_manager_secret.db_password.id
}

output "db_password_secret_v1" {
    value = google_secret_manager_secret_version.db_password_v1.id
}

output "db_user_secret_id" {
    value = google_secret_manager_secret.db_user.id
}

output "db_user_secret_v1" {
    value = google_secret_manager_secret_version.db_user_v1.id
}