
resource "aws_iam_user" "onebank_user" {
    name = "${var.APPLICATION_ID}-user-${var.ENVIRONMENT}"
    tags = local.common_tags
}

resource "aws_iam_group_membership" "developers-membership" {
    name = "onebank-administrator-membership"
    users = [
        aws_iam_user.onebank_user.name
    ]
    group = data.aws_iam_group.onebank_group.group_name

    depends_on = [ aws_iam_user.onebank_user ]
}

resource "aws_iam_access_key" "onebank_user_access_key" {
    user = aws_iam_user.onebank_user.name
    status = "Active"
}

resource "aws_iam_user_login_profile" "onebank_user_login_profile" {
    user = aws_iam_user.onebank_user.name
}
