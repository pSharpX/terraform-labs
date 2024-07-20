# https://cloud.google.com/artifact-registry/docs/overview

resource "google_artifact_registry_repository" "docker_upstream_1" {
    location = var.REGION
    repository_id = local.docker_hub_upstream
    description = "Remote Repository for Docker Hub images"
    format = "DOCKER"
    mode = "REMOTE_REPOSITORY"
    labels = local.common_tags

    remote_repository_config {
        description = "Docker Hub"
        docker_repository {
            public_repository = "DOCKER_HUB"
        }
    }
}

resource "google_artifact_registry_repository" "docker_upstream_2" {
    location = var.REGION
    repository_id = local.main_upstream
    description = "Repository for storing Onebank Docker images"
    format = "DOCKER"
    mode = "STANDARD_REPOSITORY"
    labels = local.common_tags

    docker_config {
        immutable_tags = true
    }

    cleanup_policies {
        id = "keep-prod-release"
        action = "KEEP"

        condition {
            tag_state = "TAGGED"
            tag_prefixes = ["prod"]
        }
    }

    cleanup_policies {
        id = "keep-minimun-versions"
        action = "KEEP"

        most_recent_versions {
            keep_count = 5
        }
    }

    cleanup_policies {
        id = "gc-untagged"
        action = "DELETE"

        condition {
            tag_state = "UNTAGGED"
            older_than = "2592000s"
        }
    }
}

resource "google_artifact_registry_repository" "onebank_repository" {
    location = var.REGION
    repository_id = local.applicationId
    description = "Virtual Repository for Onebank Docker images"
    format = "DOCKER"
    mode = "VIRTUAL_REPOSITORY"
    labels = local.common_tags

    virtual_repository_config {
        upstream_policies {
            id = local.docker_hub_upstream
            repository = google_artifact_registry_repository.docker_upstream_1.id
            priority = 100
        }

        upstream_policies {
            id = local.main_upstream
            repository = google_artifact_registry_repository.docker_upstream_2.id
            priority = 200
        }
    }

    depends_on = [ 
        google_artifact_registry_repository.docker_upstream_1,
        google_artifact_registry_repository.docker_upstream_2
    ]
}