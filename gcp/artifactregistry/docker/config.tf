data "template_file" "login_access_token" {
    template = file("./templates/login-access-token.sh.tmpl")

    vars = {
        location = google_artifact_registry_repository.onebank_repository.location
        user = "oauth2accesstoken"
        access_token = data.google_service_account_access_token.global.access_token
    }
}

resource "local_file" "login_access_token" {
    content = data.template_file.login_access_token.rendered
    filename = "./configs/login-access-token.credential.sh"
}

data "template_file" "login_service_account" {
    template = file("./templates/login-service-account.sh.tmpl")

    vars = {
        location = google_artifact_registry_repository.onebank_repository.location
        key_type = "_json_key_base64"
        service_account_key = google_service_account_key.global_artifact_key.private_key
    }
}

resource "local_file" "login_service_account" {
    content = data.template_file.login_service_account.rendered
    filename = "./configs/login-service-account.credential.sh"
}

data "template_file" "login_auth_config" {
    template = file("./templates/config.json.tmpl")

    vars = {
        repository = "${google_artifact_registry_repository.onebank_repository.location}-docker.pkg.dev"
        auth_token = base64encode("oauth2accesstoken:${data.google_service_account_access_token.global.access_token}")
    }
}

resource "local_file" "login_auth_config" {
    content = data.template_file.login_auth_config.rendered
    filename = "./configs/config.credential.json"
}

