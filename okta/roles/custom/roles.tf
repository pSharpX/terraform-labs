# https://developer.okta.com/docs/api/openapi/okta-management/guides/roles/#standard-roles
# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group_role
# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/admin_role_custom
# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/resource_set

resource "okta_admin_role_custom" "onebank_administrator_role" {
    label = "${local.applicationId}-administrator-role"
    description = "A custom role for onebank administrator users"
    permissions = [
        "okta.users.manage",
        "okta.users.lifecycle.manage",
        "okta.users.userprofile.manage",
        "okta.users.credentials.manage",
        "okta.users.groupMembership.manage",
        "okta.users.appAssignment.manage",
        "okta.groups.members.manage",
        "okta.groups.manage",
        "okta.groups.appAssignment.manage",
        "okta.apps.assignment.manage",
        "okta.apps.manage",
        "okta.authzServers.manage"
    ]
}

resource "okta_admin_role_custom" "onebank_general_role" {
    label = "${local.applicationId}-general-role"
    description = "A custom role for onebank general users"
    permissions = [
        "okta.users.read",
        "okta.groups.read",
        "okta.apps.read",
        "okta.apps.clientCredentials.read",
        "okta.authzServers.read"
    ]
}

resource "okta_resource_set" "uri_based_resource_set" {
    label = "AllUsersAppsGroups_URI"
    description = "All the users, apps and groups"
    resources = [
        "${local.org_url}/api/v1/users",
        "${local.org_url}/api/v1/groups",
        "${local.org_url}/api/v1/apps",
        "${local.org_url}/api/v1/authorizationServers"
    ]
}

resource "okta_resource_set" "orn_based_resource_set" {
    label = "AllUsersAppsGroups_ORN"
    description = "All the users, apps and groups"
    resources = [
        "orn:okta:directory:${data.okta_org_metadata.__.id}:users",
        "orn:okta:directory:${data.okta_org_metadata.__.id}:groups",
        "orn:okta:idp:${data.okta_org_metadata.__.id}:apps",
        "orn:okta:idp:${data.okta_org_metadata.__.id}:authorization_servers"
    ]
}

resource "okta_group_role" "onebank_administrator_role_binding" {
    group_id = okta_group.administrator_group.id
    role_id = okta_admin_role_custom.onebank_administrator_role.id
    resource_set_id = okta_resource_set.orn_based_resource_set.id
    role_type = "CUSTOM"
}

resource "okta_group_role" "onebank_general_role_binding" {
    group_id = okta_group.general_group.id
    role_id = okta_admin_role_custom.onebank_general_role.id
    resource_set_id = okta_resource_set.uri_based_resource_set.id
    role_type = "CUSTOM"
}