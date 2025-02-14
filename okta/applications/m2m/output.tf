output "authorization_server_id" {
    value = okta_auth_server.onebank.id
}

output "issuer_url" {
    value = okta_auth_server.onebank.issuer
}