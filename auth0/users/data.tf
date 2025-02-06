# https://registry.terraform.io/providers/auth0/auth0/latest/docs/data-sources/connection

data "auth0_connection" "username_password_connection" {
    name = var.DEFAULT_CONNECTION
}

data "auth0_role" "administrator_role" {
    role_id = var.ROLE_ID
}