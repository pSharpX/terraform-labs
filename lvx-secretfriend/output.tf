
output "application_role_name" {
  value = aws_iam_role.application_role.name
}

output "application_role_id" {
  value = aws_iam_role.application_role.id
}

output "application_role_arn" {
  value = aws_iam_role.application_role.arn
}

output "application_user" {
  value = aws_iam_user.application_user.arn
}

output "application_user_credential_id" {
  value = aws_iam_access_key.application_user_access_key.id
}

output "application_user_credential_secret" {
  sensitive = true
  value     = aws_iam_access_key.application_user_access_key.secret
}

output "application_user_login_profile" {
  sensitive = true
  value     = aws_iam_user_login_profile.application_user_login_profile.password
}