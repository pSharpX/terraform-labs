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

data "aws_s3_bucket" "onebank-s3-bucket" {
    bucket = var.S3_BUCKET
}