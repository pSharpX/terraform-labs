# https://cloud.google.com/artifact-registry/docs/overview
# https://cloud.google.com/artifact-registry/docs/repositories/remote-overview

# The other repository modes are:

# Standard: The default repository mode. You upload or publish artifacts such as private packages directly to standard repositories. Although you can download directly from individual standard repositories, accessing groups of repositories with a virtual repository simplifies tool configuration.
# Virtual: A repository that acts as a single access point for multiple upstream repositories, including remote and standard repositories.

resource "google_artifact_registry_repository" "remote_upstream_1" {
    location = var.REGION
    repository_id = local.remote_upstream
    description = "Remote Repository for Docker Hub"
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

resource "google_artifact_registry_repository" "private_upstream_1" {
    location = var.REGION
    repository_id = local.private_upstream
    description = "Repository for storing Docker Images"
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
    repository_id = local.repository_name
    description = "Virtual Repository for Onebank Docker Images"
    format = "DOCKER"
    mode = "VIRTUAL_REPOSITORY"
    labels = local.common_tags

    virtual_repository_config {
        upstream_policies {
            id = local.remote_upstream
            repository = google_artifact_registry_repository.remote_upstream_1.id
            priority = 100
        }

        upstream_policies {
            id = local.private_upstream
            repository = google_artifact_registry_repository.private_upstream_1.id
            priority = 200
        }
    }

    depends_on = [ 
        google_artifact_registry_repository.remote_upstream_1,
        google_artifact_registry_repository.private_upstream_1
    ]
}