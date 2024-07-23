output "project_number" {
    value = data.google_project.onebank.number
}

output "repository_id" {
    value = google_artifact_registry_repository.onebank_repository.id
}

output "repository_name" {
    value = google_artifact_registry_repository.onebank_repository.name
}

output "repository_url" {
    value = "artifactregistry://${google_artifact_registry_repository.onebank_repository.location}-maven.pkg.dev/${google_artifact_registry_repository.onebank_repository.project}/${google_artifact_registry_repository.onebank_repository.name}"
}

output "glogal_sa_email" {
    value = google_service_account.global_artifact_sa.email
}

output "repository_sa_email" {
    value = google_service_account.repository_specific_sa.email
}
