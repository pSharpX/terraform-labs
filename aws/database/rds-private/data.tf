data "aws_vpc"  "onebank-vpc"{
    id = var.VPC_ID
}

data "aws_subnet" "main-public-1" {
    id = element(var.DB_SUBNETS, 0)
}

data "aws_subnet" "main-public-2" {
    id = element(var.DB_SUBNETS, 1)
}


data "aws_subnet" "main-private-1" {
    id = element(var.DB_SUBNETS, 2)
}

data "aws_subnet" "main-private-2" {
    id = element(var.DB_SUBNETS, 3)
}

data "aws_rds_engine_version" "postgres-engine" {
    engine = "postgres"
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

data "aws_ami" "al2023" {
    most_recent = true

    filter {
        name = "name"
        values = ["al2023-ami-2023*-x86_64", "al2023-ami-minimal-2023*-x86_64"]
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

data "aws_ami" "amazonlinux" {
    most_recent = true

    filter {
        name = "name"
        values = ["amzn2-ami-hvm*-x86_64-gp2"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name = "architecture"
        values = ["x86_64"]
    }

    owners = ["amazon"]
}

data "aws_ami" "windows" {
    most_recent = true

    filter {
        name = "platform"
        values = ["windows"]
    }

    filter {
        name = "name"
        values = ["Windows_Server-2022-English-*-Base*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name = "architecture"
        values = ["x86_64"]
    }

    owners = ["amazon"]
}