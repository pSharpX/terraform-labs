output "users" {
    value = [for user in aws_iam_user.s3-users: user.name]
}

output "users-credential-id" {
    value = [for credential in aws_iam_access_key.s3-users-access-key: credential.id]
}

output "users-credential-secret" {
    sensitive = true
    value = [for credential in aws_iam_access_key.s3-users-access-key: credential.secret]
}

output "users-login-profile" {
    sensitive = true
    value = [for profile in aws_iam_user_login_profile.s3-users-login-profile: profile.password]
}