data "aws_iam_policy" "readonlyaccess_policy" {
    name = "ReadOnlyAccess"
}

data "aws_iam_policy" "viewonlyaccess_policy" {
    name = "ViewOnlyAccess"
}

data "aws_iam_policy" "poweruseraccess_policy" {
    name = "PowerUserAccess"
}

data "aws_iam_policy" "systemadministrator_policy" {
    name = "SystemAdministrator"
}