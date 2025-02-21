output "authorization_server_id" {
    value = okta_auth_server.onebank.id
}

output "issuer_url" {
    value = okta_auth_server.onebank.issuer
}

output "rabbitmq_client_id" {
    value = okta_app_oauth.rabbitmq_app.client_id
}

output "taskmaster_client_id" {
    value = okta_app_oauth.taskmaster_app.client_id
}

output "rabbitmq_test_status_code" {
    value = data.http.test_rabbitmq_access_token.status_code
}

output "taskmaster_test_status_code" {
    value = data.http.test_taskmaster_access_token.status_code
}