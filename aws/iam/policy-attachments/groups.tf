resource "aws_iam_group" "developers" {
    name = var.DEVELOPER_GROUP
    path = "/users/developers/"
}

resource "aws_iam_group" "administrators" {
    name = var.ADMINISTRATOR_GROUP
    path = "/users/administrators/"
}

resource "aws_iam_group" "external_groups" {
    for_each = var.GROUPS
    name = each.value
    path = "/users/externals/"
}