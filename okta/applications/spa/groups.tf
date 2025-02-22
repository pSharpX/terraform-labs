# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group

resource "okta_group" "rabbitmq_administrator_group" {
    name = "${local.applicationId}-rabbitmq-administrator-group"
    description = "Custom group for users with rabbitmq administrator role"
}

resource "okta_group" "rabbitmq_consumer_group" {
    name = "${local.applicationId}-rabbitmq-consumer-group"
    description = "Custom group for users with rabbitmq consumer role"
}

resource "okta_group" "rabbitmq_producer_group" {
    name = "${local.applicationId}-rabbitmq-producer-group"
    description = "Custom group for users with rabbitmq producer role"
}

resource "okta_group" "taskmaster_group" {
    name = "${local.applicationId}-taskmaster-group"
    description = "Custom group for user with taskmaster role"
}

resource "okta_group" "custom_admin_group" {
    name = "${local.applicationId}-custom-admin-group"
    description = "Custom group for onebank users with read_only admin permissions"
}