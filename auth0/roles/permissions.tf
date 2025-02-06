# https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/role_permissions

resource "auth0_role_permissions" "producer_role_permissions" {
    role_id = auth0_role.rabbitmq_producer_role.id

    permissions {
        name = auth0_resource_server_scope.write_scope.scope
        resource_server_identifier = auth0_resource_server.onebank_rabbitmq.identifier
    }
}

resource "auth0_role_permissions" "consumer_role_permissions" {
    role_id = auth0_role.rabbitmq_consumer_role.id

    permissions {
        name = auth0_resource_server_scope.read_scope.scope
        resource_server_identifier = auth0_resource_server.onebank_rabbitmq.identifier
    }
}

resource "auth0_role_permissions" "administrator_role_permissions" {
    role_id = auth0_role.rabbitmq_administrator_role.id

    permissions {
        name = auth0_resource_server_scope.read_scope.scope
        resource_server_identifier = auth0_resource_server.onebank_rabbitmq.identifier
    }

    permissions {
        name = auth0_resource_server_scope.write_scope.scope
        resource_server_identifier = auth0_resource_server.onebank_rabbitmq.identifier
    }

    permissions {
        name = auth0_resource_server_scope.configure_scope.scope
        resource_server_identifier = auth0_resource_server.onebank_rabbitmq.identifier
    }
}