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

    owners = ["amazon"]
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