# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership
# "aws_iam_group_membership" will conflict with itself if used more than once with the same group. To non-exclusively manage the users in a group, see the "aws_iam_user_group_membership" resource.
 
resource "aws_iam_group_membership" "developers-membership" {
    name = "developers-membership"
    users = var.DEVELOVER_USERS
    group = data.aws_iam_group.developer-group.group_name

    depends_on = [ aws_iam_user.developer-users ]
}

resource "aws_iam_group_membership" "administrator-membership" {
    name = "administrator-membership"
    users = var.ADMINISTRATOR_USERS
    group = data.aws_iam_group.administrator-group.group_name

    depends_on = [ aws_iam_user.administrator-users ]
}

resource "aws_iam_group_membership" "externals-membership" {
    name = "externals-membership"
    users = [ aws_iam_user.external-user.name ]
    group = data.aws_iam_group.external-group.group_name
}

resource "aws_iam_group_membership" "contractors-membership" {
    name = "contractors-membership"
    users = [ aws_iam_user.contractor-user.name ]
    group = data.aws_iam_group.contractor-group.group_name
}

resource "aws_iam_group_membership" "guests-membership" {
    name = "guests-membership"
    users = [ aws_iam_user.guest-user.name ]
    group = data.aws_iam_group.guest-group.group_name
}
