resource "aws_iam_group" "developers" {
    name = var.DEVELOPER_GROUP
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment
# The aws_iam_policy_attachment resource creates exclusive attachments of IAM policies. 
# Across the entire AWS account, all of the users/roles/groups to which a single policy is attached must be declared by a single aws_iam_policy_attachment resource. 

resource "aws_iam_policy_attachment" "developers_attach" {
    name = "${var.DEVELOPER_GROUP}-attach"
    groups = [ aws_iam_group.developers.name ]
    policy_arn = data.aws_iam_policy.systemadministrator_policy.arn
}

resource "aws_iam_group" "administrators" {
    name = var.ADMINISTRATOR_GROUP
}

resource "aws_iam_policy_attachment" "administrator_attach" {
    name = "${var.ADMINISTRATOR_GROUP}-attach"
    groups = [aws_iam_group.administrators.name]
    policy_arn = data.aws_iam_policy.poweruseraccess_policy.arn
}

resource "aws_iam_group" "external_groups" {
    for_each = var.GROUPS
    name = each.value
}

resource "aws_iam_policy_attachment" "external_groups_attach" {
    name = "external-groups-attach"
    groups = [for group in aws_iam_group.external_groups: group.name]
    policy_arn = data.aws_iam_policy.viewonlyaccess_policy.arn
}