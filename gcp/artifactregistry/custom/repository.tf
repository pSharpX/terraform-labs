# https://cloud.google.com/artifact-registry/docs/overview

resource "google_artifact_registry_repository" "onebank_repository" {
    location = var.REGION
    repository_id = local.applicationId
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