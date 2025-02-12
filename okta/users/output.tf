output "admin_user_id" {
    value = okta_user.admin_user.id
}

output "users_id" {
    value = {
        for user in okta_user.users: user.email => user.id
    }
}