output "resource_server_id" {
    value = auth0_resource_server.onebank_rabbitmq.id
}

output "rabbitmq_producer_role_id" {
    value = auth0_role.rabbitmq_producer_role.id
}

output "rabbitmq_consumer_role_id" {
    value = auth0_role.rabbitmq_consumer_role.id
}

output "rabbitmq_administrator_role_id" {
    value = auth0_role.rabbitmq_administrator_role.id
}