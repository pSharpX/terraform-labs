data "aws_vpc"  "onebank_vpc"{
    id = var.VPC_ID
}

data "aws_subnet" "main_public_1" {
    id = element(var.PUBLIC_SUBNETS, 0)
}

data "aws_subnet" "main_public_2" {
    id = element(var.PUBLIC_SUBNETS, 1)
}


data "aws_subnet" "main_private_1" {
    id = element(var.PRIVATE_SUBNETS, 2)
}

data "aws_subnet" "main_private_2" {
    id = element(var.PRIVATE_SUBNETS, 3)
}

data "aws_iam_policy" "AWSElasticBeanstalkWebTier" {
    name = "AWSElasticBeanstalkWebTier"
}

data "aws_iam_policy" "AWSElasticBeanstalkServiceRolePolicy" {
    name = "AWSElasticBeanstalkServiceRolePolicy"
}

data "aws_iam_policy" "AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy" {
    name = "AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy"
}

data "aws_iam_policy" "AWSElasticBeanstalkEnhancedHealth" {
    name = "AWSElasticBeanstalkEnhancedHealth"
}

data "aws_elastic_beanstalk_solution_stack" "docker" {
    most_recent = true
    name_regex = "^64bit Amazon Linux (.*) running Docker$"
}

data "aws_elastic_beanstalk_solution_stack" "ecs" {
    most_recent = true
    name_regex = "^64bit Amazon Linux (.*) running ECS$"
}

data "aws_elastic_beanstalk_solution_stack" "java" {
    most_recent = true
    name_regex = "^64bit Amazon Linux (.*) running Corretto (.*)$"
}

data "aws_elastic_beanstalk_solution_stack" "java_17" {
    most_recent = true
    name_regex = "^64bit Amazon Linux (.*) running Corretto 17$"
}

data "aws_elastic_beanstalk_solution_stack" "dotnet" {
    most_recent = true
    name_regex = "^64bit Amazon Linux (.*) running .NET Core$"
}

data "aws_elastic_beanstalk_solution_stack" "dotnet_windows" {
    most_recent = true
    name_regex = "^64bit Windows Server (.*) running IIS (.*)$"
}

data "aws_elastic_beanstalk_solution_stack" "node" {
    most_recent = true
    name_regex = "^64bit Amazon Linux (.*) running Node.js (.*)$"
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

    owners = ["amazon"]
}
