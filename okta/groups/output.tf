output "super_admin_user" {
    value = okta_user.super_admin_user.id
}

output "developers" {
    value = {
        for user in okta_user.developers: user.email => user.id
    }
}

output "devops" {
    value = {
        for user in okta_user.devops: user.email => user.id
    }
}

output "developer_group" {
    value = okta_group.developer.id
}

output "devops_group" {
    value = okta_group.devops.id
}

output "admin_group" {
    value = data.okta_group.admin.id
}