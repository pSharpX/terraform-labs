resource "aws_iam_user" "s3-users" {
    for_each = var.USERS
    name = each.value
    tags = local.common_tags
}

resource "aws_iam_access_key" "s3-users-access-key" {
    for_each = var.USERS
    user = each.value
    depends_on = [ aws_iam_user.s3-users ]
}

resource "aws_iam_user_login_profile" "s3-users-login-profile" {
    for_each = var.USERS
    user = each.value
    depends_on = [ aws_iam_user.s3-users ]
}