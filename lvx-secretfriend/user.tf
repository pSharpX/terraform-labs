
resource "aws_iam_user" "application_user" {
  name = local.application_user_name
  tags = local.common_tags
}

resource "aws_iam_group_membership" "developers-membership" {
  name = "${local.application_user_name}-${var.USER_GROUP}-membership"
  users = [
    aws_iam_user.application_user.name
  ]
  group = data.aws_iam_group.application_user_group.group_name

  depends_on = [aws_iam_user.application_user]
}

resource "aws_iam_access_key" "application_user_access_key" {
  user   = aws_iam_user.application_user.name
  status = "Active"
}

resource "aws_iam_user_login_profile" "application_user_login_profile" {
  user = aws_iam_user.application_user.name
}
