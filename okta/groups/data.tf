# https://registry.terraform.io/providers/auth0/auth0/latest/docs/data-sources/connection

data "okta_group" "admin" {
    id = var.ADMIN_GROUP
    include_users = false
}