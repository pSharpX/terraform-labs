
resource "aws_security_group" "allow-postgres-sg" {
    vpc_id = data.aws_vpc.onebank-vpc.id
    name = local.sg_name
    description = "Rules for configuring inbound/outbound traffic for database"
    tags = local.secgroup_tags
}

resource "aws_vpc_security_group_ingress_rule" "allow-postgres-ipv4" {
    security_group_id = aws_security_group.allow-postgres-sg.id
    description = "Allow ingress traffic for PostgreSQL Database"
    from_port = 5432
    to_port = 5432
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
    tags = local.common_tags
}

resource "aws_security_group" "allow-ssh-sg" {
    vpc_id = data.aws_vpc.onebank-vpc.id
    name = local.instance_sg_name
    description = "Rules for configuring inbound/outbound traffic for instance"
    tags = local.instance_sg_tags
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh-ipv4" {
    security_group_id = aws_security_group.allow-ssh-sg.id
    description = "Allow SSH ingress traffic"
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
    tags = local.common_tags
}

resource "aws_vpc_security_group_egress_rule" "allow-all" {
    security_group_id = aws_security_group.allow-ssh-sg.id
    description = "Allow all outbound traffic"
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
    tags = local.common_tags
}