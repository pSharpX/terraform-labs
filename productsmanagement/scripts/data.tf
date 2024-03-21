data "aws_vpc"  "vpc"{
    id = var.VPC_ID
}

data "aws_subnet" "main_public_1" {
    id = element(var.PUBLIC_SUBNETS, 0)
}

data "aws_subnet" "main_public_2" {
    id = element(var.PUBLIC_SUBNETS, 1)
}

data "aws_subnet" "main_private_1" {
    id = element(var.PRIVATE_SUBNETS, 0)
}

data "aws_subnet" "main_private_2" {
    id = element(var.PRIVATE_SUBNETS, 1)
}

data "aws_rds_engine_version" "db_engine" {
    engine = var.DB_ENGINE
    default_only = true
}

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name = "architecture"
        values = ["x86_64"]
    }

    owners = ["099720109477"]
}