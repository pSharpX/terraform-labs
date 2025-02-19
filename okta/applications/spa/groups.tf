# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group

resource "okta_group" "rabbitmq_group" {
    name = "${local.applicationId}-rabbitmq-group"
    description = "Custom group for user with rabbitmq role"
}

resource "okta_group" "taskmaster_group" {
    name = "${local.applicationId}-taskmaster-group"
    description = "Custom group for user with taskmaster role"
}

resource "okta_group" "custom_admin_group" {
    name = "${local.applicationId}-custom-admin-group"
    description = "Custom group for onebank users with specific admin permissions"
}