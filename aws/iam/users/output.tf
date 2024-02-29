output "developer_users" {
    value = [for user in aws_iam_user.developer-users: user.arn]
}

output "adminstrator_users" {
    value = [for user in aws_iam_user.administrator-users: user.arn]
}