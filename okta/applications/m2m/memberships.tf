# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group_memberships

resource "okta_group_memberships" "rabbitmq_membership" {
    group_id = okta_group.rabbitmq_group.id
    users = [for user in okta_user.developers: user.id]

    depends_on = [ okta_user.developers ]
}

resource "okta_group_memberships" "taskmaster_membership" {
    group_id = okta_group.taskmaster_group.id
    users = [for user in okta_user.devops: user.id]

    depends_on = [ okta_user.devops ]
}

resource "okta_group_memberships" "custom_admin_membership" {
    group_id = okta_group.custom_admin_group.id
    users = [ okta_user.super_admin_user.id ]
}
