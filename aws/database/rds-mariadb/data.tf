data "aws_vpc"  "onebank-vpc"{
    id = var.VPC_ID
}

data "aws_subnet" "main-public-1" {
    id = element(var.DB_SUBNETS, 0)
}

data "aws_subnet" "main-public-2" {
    id = element(var.DB_SUBNETS, 1)
}