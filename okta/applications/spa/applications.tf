# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_oauth
# https://github.com/oktadev/okta-dac/blob/master/terraform/main.tf

resource "okta_app_oauth" "rabbitmq_app" {
    label = local.rabbitmq_application
    type = "browser"
    grant_types = [
        "authorization_code"
    ]
    response_types = [
        "code"
    ]
    hide_ios = true
    hide_web = true
    pkce_required = true
    redirect_uris = var.ALLOWED_CALLBACK_URLS
    token_endpoint_auth_method = "none"
    post_logout_redirect_uris = [
        "https://localhost:15672"
    ]
    logo_uri = "https://gravatar.com/avatar/adf7df330484a1406f2d8544cf9fc7ff?s=400&d=robohash&r=x"
    status = "ACTIVE"
}

resource "okta_app_oauth" "taskmaster_app" {
    label = local.taskmaster_application
    type = "web"
    grant_types = [
        "authorization_code",
        "refresh_token",
        "implicit"
    ]
    response_types = [
        "code",
        "token",
        "id_token",
    ]
    omit_secret = false
    hide_ios = true
    hide_web = true
    pkce_required = false
    redirect_uris = var.ALLOWED_CALLBACK_URLS
    post_logout_redirect_uris = [
        "https://localhost:15672"
    ]
    logo_uri = "https://gravatar.com/avatar/291b3a483a858804d385e1d7591e0a03?s=400&d=robohash&r=x"
    status = "ACTIVE"
}