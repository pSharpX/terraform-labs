# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_oauth

resource "okta_app_oauth" "rabbitmq_m2m" {
    label = local.rabbitmq_application
    type = "service"
    grant_types = [ "client_credentials" ]
    logo_uri = "https://gravatar.com/avatar/adf7df330484a1406f2d8544cf9fc7ff?s=400&d=robohash&r=x"
    status = "ACTIVE"
}

resource "okta_app_oauth" "taskmaster_m2m" {
    label = local.taskmaster_application
    type = "service"
    grant_types = [ "client_credentials" ]
    logo_uri = "https://gravatar.com/avatar/291b3a483a858804d385e1d7591e0a03?s=400&d=robohash&r=x"
    status = "ACTIVE"
}