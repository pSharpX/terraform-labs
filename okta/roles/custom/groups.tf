# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group

resource "okta_group" "general_group" {
    name = "${local.applicationId}-general-group"
    description = "Custom group for user with default permission"
}

resource "okta_group" "administrator_group" {
    name = "${local.applicationId}-administrator-group"
    description = "Custom group for user with group administrator role"
}

resource "okta_group" "readonly_admin_group" {
    name = "${local.applicationId}-readonly-admin-group"
    description = "Custom group for onebank users with READ-ONLY role/permissions"
}

resource "okta_group" "super_admin_group" {
    name = "${local.applicationId}-super-admin-group"
    description = "Custom group for onebank users with SUPER-ADMIN role/permissions"
}