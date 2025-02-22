output "authorization_server_id" {
    value = okta_auth_server.onebank.id
}

output "issuer_url" {
    value = okta_auth_server.onebank.issuer
}

output "rabbitmq_management_client_id" {
    value = okta_app_oauth.rabbitmq_management_app.client_id
}

output "rabbitmq_consumer_client_id" {
    value = okta_app_oauth.rabbitmq_consumer_m2m_app.client_id
}

output "rabbitmq_producer_client_id" {
    value = okta_app_oauth.rabbitmq_producer_m2m_app.client_id
}

output "taskmaster_client_id" {
    value = okta_app_oauth.taskmaster_app.client_id
}

output "rabbitmq_consumer_test_status_code" {
    value = data.http.test_rabbitmq_consumer_access_token.status_code
}
