# https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/client

resource "auth0_client" "task_master_client" {
    name = local.client_application_name
    description = "Auth0 Client for TaskMaster application"
    app_type = "spa"
    custom_login_page_on = false
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
        "refresh_token"
    ]
}