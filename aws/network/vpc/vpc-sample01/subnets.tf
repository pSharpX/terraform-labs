resource "aws_subnet" "main-public-1" {
    vpc_id = aws_vpc.vpc-sample01.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
    tags = merge({Name: "main-public-1", Tier: "Public"}, local.common_tags)
}

resource "aws_subnet" "main-public-2" {
    vpc_id = aws_vpc.vpc-sample01.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1b"
    tags = merge({Name: "main-public-2", Tier: "Public"}, local.common_tags)
}

resource "aws_subnet" "main-public-3" {
    vpc_id = aws_vpc.vpc-sample01.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1c"
    tags = merge({Name: "main-public-3", Tier: "Public"}, local.common_tags)
}

resource "aws_subnet" "main-private-1" {
    vpc_id = aws_vpc.vpc-sample01.id
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = false
    availability_zone = "us-east-1a"
    tags = merge({Name: "main-private-1", Tier: "Private"}, local.common_tags)
}

resource "aws_subnet" "main-private-2" {
    vpc_id = aws_vpc.vpc-sample01.id
    cidr_block = "10.0.5.0/24"
    map_public_ip_on_launch = false
    availability_zone = "us-east-1b"
    tags = merge({Name: "main-private-2", Tier: "Private"}, local.common_tags)
}

resource "aws_subnet" "main-private-3" {
    vpc_id = aws_vpc.vpc-sample01.id
    cidr_block = "10.0.6.0/24"
    map_public_ip_on_launch = false
    availability_zone = "us-east-1c"
    tags = merge({Name: "main-private-3", Tier: "Private"}, local.common_tags)
}

resource "aws_internet_gateway" "main-igw" {
    vpc_id = aws_vpc.vpc-sample01.id
    tags = merge({Name: "main-igw"}, local.common_tags)
}

resource "aws_route_table" "main-public" {
    vpc_id = aws_vpc.vpc-sample01.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id =  "${aws_internet_gateway.main-igw.id}"
    }
    tags = merge({Name: "main-public-1"}, local.common_tags)
}

resource "aws_route_table_association" "main-public-1-a" {
    subnet_id = aws_subnet.main-public-1.id
    route_table_id = aws_route_table.main-public.id  
}

resource "aws_route_table_association" "main-public-1-b" {
    subnet_id = aws_subnet.main-public-2.id
    route_table_id = aws_route_table.main-public.id  
}

resource "aws_route_table_association" "main-public-1-c" {
    subnet_id = aws_subnet.main-public-3.id
    route_table_id = aws_route_table.main-public.id  
}