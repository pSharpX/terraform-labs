# https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/client

resource "auth0_client" "task_master_client" {
    name = local.client_application_name
    description = "Auth0 Client for TaskMaster application"
    app_type = "non_interactive"
    custom_login_page_on = false
    oidc_conformant = true
    logo_uri = "https://gravatar.com/avatar/b6e062017030ac6d3d87c2c0e997fb09?s=400&d=robohash&r=x"
    callbacks = var.ALLOWED_CALLBACK_URLS
    web_origins = var.ALLOWED_WEB_ORIGINS

    cross_origin_auth = true
    allowed_origins = var.ALLOWED_ORIGINS

    grant_types = [
        "authorization_code",
        "http://auth0.com/oauth/grant-type/password-realm",
        "implicit",
        "password",
        "refresh_token",
        "client_credentials"
    ]

    client_metadata = {
        "company" = local.applicationId
    }

    jwt_configuration {
        lifetime_in_seconds = 300
        secret_encoded = true
        alg = "RS256"
    }

    refresh_token {
        leeway = 0
        token_lifetime = 2592000
        rotation_type = "rotating"
        expiration_type = "expiring"
    }
}

resource "auth0_client_grant" "task_master_onebank" {
    client_id = auth0_client.task_master_client.client_id
    audience = auth0_resource_server.onebank.identifier
    scopes = [
        auth0_resource_server_scope.configure_scope.scope,
        auth0_resource_server_scope.read_scope.scope,
        auth0_resource_server_scope.write_scope.scope
    ]
}