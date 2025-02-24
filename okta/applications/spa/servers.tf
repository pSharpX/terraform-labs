#https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server

resource "okta_auth_server" "onebank" {
    name = local.authorization_server
    description = "Default authorization server for all onebank-concern applications"
    audiences = [ "api://${local.applicationId}" ]
    status = "ACTIVE"
}

resource "okta_trusted_origin" "rabbitmq_origin" {
    name = "rabbitmq-local-origin"
    origin = "http://localhost:15672"
    scopes = [ "CORS" ]
}

resource "okta_auth_server_claim" "rabbitmq_role_claim" {
    auth_server_id = okta_auth_server.onebank.id
    name = "role"
    value_type = "EXPRESSION"
    value = local.rabbitmq_role_claim_expression
    # claim_type (String) Specifies whether the claim is for an access token RESOURCE or ID token IDENTITY.
    claim_type = "RESOURCE"
    always_include_in_token = true
    #scopes = [  ]
    status = "ACTIVE"
}

resource "okta_auth_server_scope" "rabbitmq_write_scope" {
    auth_server_id = okta_auth_server.onebank.id
    name = "rabbitmq.write:*/*"
    display_name = "rabbitmq write"
    description = "Write permission allow users to publish to exchanges"
    consent = "IMPLICIT"
}

resource "okta_auth_server_scope" "rabbitmq_read_scope" {
    auth_server_id = okta_auth_server.onebank.id
    name = "rabbitmq.read:*/*"
    display_name = "rabbitmq read"
    description = "Read permission allows users to consume messages from queues and use bindings"
    consent = "IMPLICIT"
}

resource "okta_auth_server_scope" "rabbitmq_configure_scope" {
    auth_server_id = okta_auth_server.onebank.id
    name = "rabbitmq.configure:*/*"
    display_name = "rabbitmq configure"
    description = "Configure permission allows users to declare, modify, or delete exchanges and queues"
    consent = "IMPLICIT"
}

resource "okta_auth_server_scope" "rabbitmq_administrator_scope" {
    auth_server_id = okta_auth_server.onebank.id
    name = "rabbitmq.tag:administrator"
    display_name = "rabbitmq administrator"
    description = "administrator permission allows users to access RabbitMQ Management tool"
    consent = "IMPLICIT"
}

resource "okta_auth_server_scope" "taskmaster_write_scope" {
    auth_server_id = okta_auth_server.onebank.id
    name = "taskmaster.write:*/*"
    display_name = "taskmaster.write"
    description = "Write permission allow users to create tasks"
    consent = "IMPLICIT"
}

resource "okta_auth_server_scope" "taskmaster_read_scope" {
    auth_server_id = okta_auth_server.onebank.id
    name = "taskmaster.read:*/*"
    display_name = "taskmaster.read"
    description = "Read permission allows users to consume and read existent tasks"
    consent = "IMPLICIT"
}

resource "okta_auth_server_scope" "taskmaster_configure_scope" {
    auth_server_id = okta_auth_server.onebank.id
    name = "taskmaster.configure:*/*"
    display_name = "taskmaster.configure"
    description = "Configure permission allows users to configure or schedule tasks"
    consent = "IMPLICIT"
}
