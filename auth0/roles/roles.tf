# https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/role

resource "auth0_role" "rabbitmq_producer_role" {
    name = var.PRODUCER_ROLE
    description = "Custom role for rabbitmq producer users"
}

resource "auth0_role" "rabbitmq_consumer_role" {
    name = var.CONSUMER_ROLE
    description = "Custom role for rabbitmq consumer users"
}

resource "auth0_role" "rabbitmq_administrator_role" {
    name = var.ADMINISTRATOR_ROLE
    description = "Custom role for rabbitmq administrator users"
}