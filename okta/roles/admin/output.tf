output "super_admin_group" {
    value = okta_group.super_admin_group.id
}

output "readonly_admin_group" {
    value = okta_group.readonly_admin_group.id
}