# nat gw
resource "aws_eip" "nat" {
    vpc = true
    tags = local.common_tags
}

resource "aws_nat_gateway" "nat-gw" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.main-public-1.id
    depends_on = [ aws_internet_gateway.main-igw ]
}

# VPC setup for NAT
resource "aws_route_table" "main-private" {
    vpc_id = aws_vpc.vpc-sample01.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
    }
    tags = merge({Name: "main-private-1"}, local.common_tags)
}

# route associations private
resource "aws_route_table_association" "main-private-1-a" {
    subnet_id = aws_subnet.main-private-1.id
    route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "main-private-1-b" {
    subnet_id = aws_subnet.main-private-2.id
    route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "main-private-1-c" {
    subnet_id = aws_subnet.main-private-3.id
    route_table_id = aws_route_table.main-private.id
}