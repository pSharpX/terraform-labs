# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group_memberships

resource "okta_group_memberships" "general_membership" {
    group_id = okta_group.general_group.id
    users = [for user in okta_user.users: user.id]

    depends_on = [ okta_user.users ]
}

resource "okta_group_memberships" "administrator_membership" {
    group_id = okta_group.administrator_group.id
    users = [for user in okta_user.administrators: user.id]

    depends_on = [ okta_user.administrators ]
}

resource "okta_group_memberships" "super_admin_membership" {
    group_id = okta_group.super_admin_group.id
    users = [ okta_user.super_admin_user.id ]
}

resource "okta_group_memberships" "readonly_admin_membership" {
    group_id = okta_group.readonly_admin_group.id
    users = [ okta_user.readonly_admin_user.id ]
}
