# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group_memberships

resource "okta_group_memberships" "developer_membership" {
    group_id = okta_group.developer.id
    users = [for user in okta_user.developers: user.id]

    depends_on = [ okta_user.developers ]
}

resource "okta_group_memberships" "devops_membership" {
    group_id = okta_group.devops.id
    users = [for user in okta_user.devops: user.id]

    depends_on = [ okta_user.devops ]
}

resource "okta_user_group_memberships" "admin_membership" {
    user_id = okta_user.super_admin_user.id
    groups = [ 
        data.okta_group.admin.id
    ]
}