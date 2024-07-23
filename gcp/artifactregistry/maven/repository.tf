# https://cloud.google.com/artifact-registry/docs/overview

resource "google_artifact_registry_repository" "maven_upstream_1" {
    location = var.REGION
    repository_id = local.maven_upstream
    description = "Remote Repository for Maven artifacts"
    format = "MAVEN"
    mode = "REMOTE_REPOSITORY"
    labels = local.common_tags

    remote_repository_config {
        description = "Maven Central"

        maven_repository {
            public_repository = "MAVEN_CENTRAL"
        }
    }
}

resource "google_artifact_registry_repository" "maven_upstream_2" {
    location = var.REGION
    repository_id = local.main_upstream
    description = "Repository for storing Maven artifacts"
    format = "MAVEN"
    mode = "STANDARD_REPOSITORY"
    labels = local.common_tags

    maven_config {
        allow_snapshot_overwrites = false
        version_policy = "SNAPSHOT"
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
    description = "Virtual Repository for Onebank Maven artifacts"
    format = "MAVEN"
    mode = "VIRTUAL_REPOSITORY"
    labels = local.common_tags

    virtual_repository_config {
        upstream_policies {
            id = local.maven_upstream
            repository = google_artifact_registry_repository.maven_upstream_1.id
            priority = 100
        }

        upstream_policies {
            id = local.main_upstream
            repository = google_artifact_registry_repository.maven_upstream_2.id
            priority = 200
        }
    }

    depends_on = [ 
        google_artifact_registry_repository.maven_upstream_1,
        google_artifact_registry_repository.maven_upstream_2
    ]
}