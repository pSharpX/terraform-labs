# https://cloud.google.com/artifact-registry/docs/overview

resource "google_artifact_registry_repository" "onebank_repository" {
    location = var.REGION
    repository_id = local.applicationId
    description = "Repository for storing Onebank Docker images"
    format = "DOCKER"
    mode = "STANDARD_REPOSITORY"
    labels = local.common_tags
}