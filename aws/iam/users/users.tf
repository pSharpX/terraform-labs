resource "aws_iam_user" "developer-users" {
    for_each = var.DEVELOVER_USERS
    name = each.value
    tags = local.common_tags
}

resource "aws_iam_user" "administrator-users" { 
    for_each = var.ADMINISTRATOR_USERS
    name = each.value
    tags = local.common_tags
}

resource "aws_iam_user" "external-user" {
    name = var.EXTERNAL_USER
    tags = local.common_tags
}

resource "aws_iam_user" "contractor-user" {
    name = var.CONTRACTOR_USER
    tags = local.common_tags
}

resource "aws_iam_user" "guest-user" {
    name = var.GUEST_USER
    tags = local.common_tags
}