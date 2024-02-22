
resource "aws_security_group" "allow-mariadb-sg" {
    vpc_id = data.aws_vpc.onebank-vpc.id
    name = local.sg_name
    description = "Rules for configuring inbound/outbound traffic for database"
    tags = local.secgroup_tags
}

resource "aws_vpc_security_group_ingress_rule" "allow-mariadb-ipv4" {
    security_group_id = aws_security_group.allow-mariadb-sg.id
    description = "MariaDB from VPC"
    from_port = 3306
    to_port = 3306
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
    tags = local.common_tags
}

resource "aws_vpc_security_group_egress_rule" "allow-all" {
    security_group_id = aws_security_group.allow-mariadb-sg.id
    description = "Allow all outbound traffic from database"
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
    tags = local.common_tags
}