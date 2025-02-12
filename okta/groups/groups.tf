# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group

resource "okta_group" "developer" {
    name = "${local.applicationId}-developer-group"
    description = "Custom group for user with developer role"
}

resource "okta_group" "devops" {
    name = "${local.applicationId}-devops-group"
    description = "Custom group for user with devops/sysadmin role"
}