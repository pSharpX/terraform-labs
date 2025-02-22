resource "okta_auth_server_policy" "default_admin_policy" {
    auth_server_id = okta_auth_server.onebank.id
    name = "default_admin_policy"
    description = "Default policy for admin users"
    priority = 1
    client_whitelist = ["ALL_CLIENTS"]
    status = "ACTIVE"
}

resource "okta_auth_server_policy_rule" "default_admin_rule" {
    auth_server_id = okta_auth_server.onebank.id
    policy_id = okta_auth_server_policy.default_admin_policy.id
    name = "default_admin_rule"
    grant_type_whitelist = [
        "authorization_code",
        "password",
        "client_credentials",
        "implicit",
    ]
    group_whitelist = [
        okta_group.custom_admin_group.id
    ]
    scope_whitelist = [
        "openid",
        "profile",
        "email"
    ]
    priority = 1
    status = "ACTIVE"
    access_token_lifetime_minutes = 60
    refresh_token_lifetime_minutes = 43200
    refresh_token_window_minutes = 10080
}

resource "okta_auth_server_policy" "default_rabbitmq_administrator_policy" {
    auth_server_id = okta_auth_server.onebank.id
    name = "default_rabbitmq_administrator_policy"
    description = "Default policy for rabbitmq administrator users"
    priority = 2
    client_whitelist = [
        okta_app_oauth.rabbitmq_management_app.id
    ]
    status = "ACTIVE"

    depends_on = [ okta_auth_server_policy.default_admin_policy ]
}

resource "okta_auth_server_policy_rule" "default_rabbitmq_administrator_rule" {
    auth_server_id = okta_auth_server.onebank.id
    policy_id = okta_auth_server_policy.default_rabbitmq_administrator_policy.id
    name = "default_rabbitmq_administrator_rule"
    grant_type_whitelist = [
        "authorization_code"
    ]
    group_whitelist = [
        okta_group.rabbitmq_administrator_group.id
    ]
    scope_whitelist = [
        okta_auth_server_scope.rabbitmq_administrator_scope.name,
        "openid",
        "profile",
        "email"
    ]

    priority = 1
    status = "ACTIVE"
    access_token_lifetime_minutes = 60
    refresh_token_lifetime_minutes = 43200
    refresh_token_window_minutes = 10080
}

resource "okta_auth_server_policy" "default_rabbitmq_consumer_policy" {
    auth_server_id = okta_auth_server.onebank.id
    name = "default_rabbitmq_consumer_policy"
    description = "Default policy for rabbitmq consumer users/clients"
    priority = 3
    client_whitelist = [
        okta_app_oauth.rabbitmq_consumer_m2m_app.id
    ]
    status = "ACTIVE"

    depends_on = [ okta_auth_server_policy.default_rabbitmq_administrator_policy ]
}

resource "okta_auth_server_policy_rule" "default_rabbitmq_consumer_rule" {
    auth_server_id = okta_auth_server.onebank.id
    policy_id = okta_auth_server_policy.default_rabbitmq_consumer_policy.id
    name = "default_rabbitmq_consumer_rule"
    grant_type_whitelist = [
        "client_credentials"
    ]
    group_whitelist = [
        okta_group.rabbitmq_consumer_group.id
    ]
    scope_whitelist = [
        okta_auth_server_scope.rabbitmq_read_scope.name,
        okta_auth_server_scope.rabbitmq_configure_scope.name
    ]

    priority = 1
    status = "ACTIVE"
    access_token_lifetime_minutes = 60
    refresh_token_lifetime_minutes = 43200
    refresh_token_window_minutes = 10080
}

resource "okta_auth_server_policy" "default_rabbitmq_producer_policy" {
    auth_server_id = okta_auth_server.onebank.id
    name = "default_rabbitmq_producer_policy"
    description = "Default policy for rabbitmq producer users/clients"
    priority = 4
    client_whitelist = [
        okta_app_oauth.rabbitmq_producer_m2m_app.id
    ]
    status = "ACTIVE"

    depends_on = [ okta_auth_server_policy.default_rabbitmq_consumer_policy ]
}

resource "okta_auth_server_policy_rule" "default_rabbitmq_producer_rule" {
    auth_server_id = okta_auth_server.onebank.id
    policy_id = okta_auth_server_policy.default_rabbitmq_producer_policy.id
    name = "default_rabbitmq_producer_rule"
    grant_type_whitelist = [
        "client_credentials"
    ]
    group_whitelist = [
        okta_group.rabbitmq_producer_group.id
    ]
    scope_whitelist = [
        okta_auth_server_scope.rabbitmq_write_scope.name,
        okta_auth_server_scope.rabbitmq_configure_scope.name
    ]

    priority = 1
    status = "ACTIVE"
    access_token_lifetime_minutes = 60
    refresh_token_lifetime_minutes = 43200
    refresh_token_window_minutes = 10080
}

resource "okta_auth_server_policy_rule" "taskmaster_default_rule" {
    auth_server_id = okta_auth_server.onebank.id
    policy_id = okta_auth_server_policy.default_admin_policy.id
    name = "default_taskmaster_rule"
    grant_type_whitelist = [
        "authorization_code",
        "client_credentials",
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
    priority = 2
    status = "ACTIVE"
    access_token_lifetime_minutes = 60
    refresh_token_lifetime_minutes = 43200
    refresh_token_window_minutes = 10080

    depends_on = [ okta_auth_server_policy_rule.default_admin_rule ]
}