
output "application_role_name" {
  value = aws_iam_role.application_role.name
}

output "application_role_id" {
  value = aws_iam_role.application_role.id
}

output "application_role_arn" {
  value = aws_iam_role.application_role.arn
}