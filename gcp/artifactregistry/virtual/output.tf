output "project_number" {
    value = data.google_project.onebank.number
}

output "repository_id" {
    value = google_artifact_registry_repository.onebank_repository.id
}

output "repository_name" {
    value = google_artifact_registry_repository.onebank_repository.name
}
