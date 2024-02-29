output "developer_group" {
    value = aws_iam_group.developers.arn
}

output "administrator_group" {
    value = aws_iam_group.administrators.arn
}

output "external_groups" {
    value = [for group in aws_iam_group.external_groups: group.arn]
}