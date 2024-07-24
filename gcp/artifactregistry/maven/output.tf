output "project_number" {
    value = data.google_project.onebank.number
}

output "virtual_repository_name" {
    value = google_artifact_registry_repository.onebank_repository.name
}

output "snapshot_repository_name" {
    value = google_artifact_registry_repository.snapshot_upstream_1.name
}

output "release_repository_name" {
    value = google_artifact_registry_repository.release_upstream_1.name
}

output "virtual_repository_url" {
    value = "https://${google_artifact_registry_repository.onebank_repository.location}-maven.pkg.dev/${google_artifact_registry_repository.onebank_repository.project}/${google_artifact_registry_repository.onebank_repository.name}"
}

output "snapshot_repository_url" {
    value = "https://${google_artifact_registry_repository.onebank_repository.location}-maven.pkg.dev/${google_artifact_registry_repository.onebank_repository.project}/${google_artifact_registry_repository.snapshot_upstream_1.name}"
}

output "release_repository_url" {
    value = "https://${google_artifact_registry_repository.onebank_repository.location}-maven.pkg.dev/${google_artifact_registry_repository.onebank_repository.project}/${google_artifact_registry_repository.release_upstream_1.name}"
}

output "glogal_sa_email" {
    value = google_service_account.global_artifact_sa.email
}

output "repository_sa_email" {
    value = google_service_account.repository_specific_sa.email
}
