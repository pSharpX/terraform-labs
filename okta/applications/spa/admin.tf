# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group_role

resource "okta_group_role" "readonly_admin_role" {
    group_id = okta_group.custom_admin_group.id
    role_type = "READ_ONLY_ADMIN"
}