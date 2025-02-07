output "resource_server_id" {
    value = auth0_resource_server.onebank.id
}

output "application_name" {
    value = auth0_client.task_master_client.name
}

output "application_id" {
    value = auth0_client.task_master_client.id
}

output "client_id" {
    value = auth0_client.task_master_client.client_id
}
