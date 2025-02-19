#https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_group_assignment

resource "okta_app_group_assignment" "rabbitmq_assignment" {
    group_id = okta_group.rabbitmq_group.id
    app_id = okta_app_oauth.rabbitmq_app.id
}

resource "okta_app_group_assignment" "taskmaster_assignment" {
    group_id = okta_group.taskmaster_group.id
    app_id = okta_app_oauth.taskmaster_app.id
}