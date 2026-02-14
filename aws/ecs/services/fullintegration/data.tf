data "aws_vpc" "default_vpc" {
  id = var.VPC_ID
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [var.VPC_ID]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.VPC_ID]
  }

  tags = {
    Tier = "Public"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.VPC_ID]
  }

  tags = {
    Tier = "Private"
  }
}

data "aws_subnet" "subnets" {
  for_each = toset(data.aws_subnets.all.ids)
  id       = each.value
}

data "aws_subnet" "public_subnets" {
  for_each = toset(data.aws_subnets.public.ids)
  id       = each.value
}

data "aws_subnet" "private_subnets" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}

data "aws_iam_policy_document" "dynamodb_read_put_policy" {
  version = "2012-10-17"

  statement {
    sid    = "ReadPutItems"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:Scan"
    ]
    resources = ["*"]
  }
}