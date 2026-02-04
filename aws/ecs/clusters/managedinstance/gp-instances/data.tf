data "aws_vpc" "default_vpc" {
    default = true
}

data "aws_subnet" "default_subnet" {
    vpc_id = data.aws_vpc.default_vpc.id
    availability_zone = "us-east-1a"
    default_for_az = true
}