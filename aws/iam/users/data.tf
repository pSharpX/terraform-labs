data "aws_iam_policy" "readonlyaccess_policy" {
    name = "ReadOnlyAccess"
}

data "aws_iam_policy" "viewonlyaccess_policy" {
    name = "ViewOnlyAccess"
}

data "aws_iam_policy" "poweruseraccess_policy" {
    name = "PowerUserAccess"
}

data "aws_iam_policy" "administratoraccess_policy" {
    name = "AdministratorAccess"
}

data "aws_iam_group" "developer-group" {
    group_name = var.DEVELOPER_GROUP
}

data "aws_iam_group" "administrator-group" {
    group_name = var.ADMINISTRATOR_GROUP
}

data "aws_iam_group" "guest-group" {
    group_name = var.GROUPS[0]
}

data "aws_iam_group" "contractor-group" {
    group_name = var.GROUPS[1]
}

data "aws_iam_group" "external-group" {
    group_name = var.GROUPS[2]
}