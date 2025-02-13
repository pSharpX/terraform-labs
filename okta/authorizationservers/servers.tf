#https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server

resource "okta_auth_server" "onebank" {
    name = local.authorization_server
    description = "Default authorization server for all onebank-concern applications"
    audiences = [ "api://onebank" ]
    status = "ACTIVE"
}

resource "okta_auth_server_policy" "default" {
    auth_server_id = okta_auth_server.onebank.id
    name = "default_policy"
    description = "Default policy for authorization server"
    priority = 1
    client_whitelist = ["ALL_CLIENTS"]
    status = "ACTIVE"
}

resource "okta_auth_server_policy_rule" "default" {
    auth_server_id = okta_auth_server.onebank.id
    policy_id = okta_auth_server_policy.default.id
    name = "default_rule"
    grant_type_whitelist = [
        "authorization_code",
        "password",
        "client_credentials",
        "implicit",
    ]
    group_whitelist = [ "EVERYONE" ]
    scope_whitelist = [ "*" ]
    priority = 1
    status = "ACTIVE"
    access_token_lifetime_minutes = 60
    refresh_token_lifetime_minutes = 43200
    refresh_token_window_minutes = 10080
}

resource "okta_auth_server_scope" "write_scope" {
    auth_server_id = okta_auth_server.onebank.id
    name = "rabbitmq.write:*/*"
    display_name = "rabbitmq.write"
    description = "Write permission allow users to publish to exchanges"
    consent = "IMPLICIT"
}

resource "okta_auth_server_scope" "read_scope" {
    auth_server_id = okta_auth_server.onebank.id
    name = "rabbitmq.read:*/*"
    display_name = "rabbitmq.read"
    description = "Read permission allows users to consume messages from queues and use bindings"
    consent = "IMPLICIT"
}

resource "okta_auth_server_scope" "configure_scope" {
    auth_server_id = okta_auth_server.onebank.id
    name = "rabbitmq.configure:*/*"
    display_name = "rabbitmq.configure"
    description = "Configure permission allows users to declare, modify, or delete exchanges and queues"
    consent = "IMPLICIT"
}
