# https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/resource_server

resource "auth0_resource_server" "onebank" {
    name = local.resource_server_name
    identifier = local.resource_server_name
    signing_alg = "RS256"
    token_lifetime = 8600

    allow_offline_access = false
    # Enable RBAC
    enforce_policies = true
    token_dialect = "access_token_authz"
}

resource "auth0_resource_server_scope" "write_scope" {
    resource_server_identifier = auth0_resource_server.onebank.id
    scope = "rabbitmq.write:*/*"
    description = "Write permission allow users to publish to exchanges"
}

resource "auth0_resource_server_scope" "read_scope" {
    resource_server_identifier = auth0_resource_server.onebank.id
    scope = "rabbitmq.read:*/*"
    description = "Read permission allows users to consume messages from queues and use bindings"
}

resource "auth0_resource_server_scope" "configure_scope" {
    resource_server_identifier = auth0_resource_server.onebank.id
    scope = "rabbitmq.configure:*/*"
    description = "Configure permission allows users to declare, modify, or delete exchanges and queues"
}