data "template_file" "gradleconfig" {
    template = file("./templates/gradle.properties.tmpl")

    vars = {
        artifactory_contextUrl = "https://${google_artifact_registry_repository.onebank_repository.location}-maven.pkg.dev/${google_artifact_registry_repository.onebank_repository.project}/${google_artifact_registry_repository.onebank_repository.name}"
        artifactory_user = "_json_key_base64"
        artifactory_password = google_service_account_key.global_artifact_key.private_key
        snapshot_repository_url = "https://${google_artifact_registry_repository.onebank_repository.location}-maven.pkg.dev/${google_artifact_registry_repository.onebank_repository.project}/${google_artifact_registry_repository.snapshot_upstream_1.name}"
        release_repository_url = "https://${google_artifact_registry_repository.onebank_repository.location}-maven.pkg.dev/${google_artifact_registry_repository.onebank_repository.project}/${google_artifact_registry_repository.release_upstream_1.name}"
    }
}

resource "local_file" "gradleconfig" {
    content = data.template_file.gradleconfig.rendered
    filename = "./configs/gradle.properties"
}