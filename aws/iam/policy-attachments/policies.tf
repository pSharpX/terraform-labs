# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment

# The aws_iam_policy_attachment resource creates exclusive attachments of IAM policies. 
# Across the entire AWS account, all of the users/roles/groups to which a single policy is attached must be declared by a single aws_iam_policy_attachment resource. 

# Consider aws_iam_role_policy_attachment, aws_iam_user_policy_attachment, or aws_iam_group_policy_attachment instead. 
# These resources do not enforce exclusive attachment of an IAM policy.

resource "aws_iam_group_policy_attachment" "developers_attach" {
    group = aws_iam_group.developers.name
    policy_arn = data.aws_iam_policy.poweruseraccess_policy.arn
}

resource "aws_iam_group_policy_attachment" "administrator_attach" {
    group = aws_iam_group.administrators.name
    policy_arn = data.aws_iam_policy.administratoraccess_policy.arn
}

resource "aws_iam_group_policy_attachment" "external_groups_attach" {
    for_each = var.GROUPS
    group = each.value
    policy_arn = data.aws_iam_policy.viewonlyaccess_policy.arn

    depends_on = [ aws_iam_group.external_groups ]
}