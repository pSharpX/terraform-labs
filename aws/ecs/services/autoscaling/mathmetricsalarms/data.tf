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

data "aws_ecs_cluster" "default" {
  cluster_name = var.CLUSTER_ARN
}