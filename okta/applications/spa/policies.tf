resource "okta_auth_server_policy" "default" {
    auth_server_id = okta_auth_server.onebank.id
    name = "default_policy"
    description = "Default policy for authorization server"
    priority = 1
    client_whitelist = ["ALL_CLIENTS"]
    status = "ACTIVE"
}

resource "okta_auth_server_policy_rule" "default_rule" {
    auth_server_id = okta_auth_server.onebank.id
    policy_id = okta_auth_server_policy.default.id
    name = "default_rule"
    grant_type_whitelist = [
        "authorization_code",
        "password",
        "client_credentials",
        "implicit",
    ]
    user_whitelist = [
        okta_user.super_admin_user.id
    ]
    scope_whitelist = [ "*" ]
    priority = 1
    status = "ACTIVE"
    access_token_lifetime_minutes = 60
    refresh_token_lifetime_minutes = 43200
    refresh_token_window_minutes = 10080
}

resource "okta_auth_server_policy_rule" "rabbitmq_default_rule" {
    auth_server_id = okta_auth_server.onebank.id
    policy_id = okta_auth_server_policy.default.id
    name = "default_rabbitmq_rule"
    grant_type_whitelist = [
        "authorization_code",
        "password"
    ]
    group_whitelist = [
        okta_group.rabbitmq_group.id
    ]
    scope_whitelist = [
        okta_auth_server_scope.rabbitmq_write_scope.name,
        okta_auth_server_scope.rabbitmq_read_scope.name,
        okta_auth_server_scope.rabbitmq_configure_scope.name
    ]
    priority = 2
    status = "ACTIVE"
    access_token_lifetime_minutes = 60
    refresh_token_lifetime_minutes = 43200
    refresh_token_window_minutes = 10080
    
    depends_on = [ okta_auth_server_policy_rule.default_rule ]
}

resource "okta_auth_server_policy_rule" "taskmaster_default_rule" {
    auth_server_id = okta_auth_server.onebank.id
    policy_id = okta_auth_server_policy.default.id
    name = "default_taskmaster_rule"
    grant_type_whitelist = [
        "authorization_code",
        "password"
    ]
    group_whitelist = [
        okta_group.taskmaster_group.id
    ]
    scope_whitelist = [
        okta_auth_server_scope.taskmaster_write_scope.name,
        okta_auth_server_scope.taskmaster_read_scope.name,
        okta_auth_server_scope.taskmaster_configure_scope.name
    ]
    priority = 3
    status = "ACTIVE"
    access_token_lifetime_minutes = 60
    refresh_token_lifetime_minutes = 43200
    refresh_token_window_minutes = 10080

    depends_on = [ okta_auth_server_policy_rule.rabbitmq_default_rule ]
}