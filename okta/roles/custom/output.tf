output "org_id" {
    value = data.okta_org_metadata.__.id
}

output "org_url" {
    value = local.org_url
}

output "super_admin_group" {
    value = okta_group.super_admin_group.id
}

output "readonly_admin_group" {
    value = okta_group.readonly_admin_group.id
}