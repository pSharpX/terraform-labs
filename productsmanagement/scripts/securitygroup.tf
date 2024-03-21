
resource "aws_security_group" "database_sg" {
    vpc_id = data.aws_vpc.vpc.id
    name = local.database_sg_name
    description = "Rules for configuring inbound/outbound traffic for database"
    tags = local.database_sg_tags
}

resource "aws_vpc_security_group_egress_rule" "db_allow_all_egress_rule" {
    security_group_id = aws_security_group.database_sg.id
    description = "Allow all outbound traffic"
    to_port = 0
    from_port = 0
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "db_allow_instance_ingress_rule" {
    security_group_id = aws_security_group.database_sg.id
    description = "Allow ingress traffic from Backend Instance"
    referenced_security_group_id = aws_security_group.instance_sg.id
    to_port = 0
    from_port = 0
    ip_protocol = "-1"
}

resource "aws_security_group" "instance_sg" {
    vpc_id = data.aws_vpc.vpc.id
    name = local.instance_sg_name
    description = "Rules for configuring inbound/outbound traffic for instance"
    tags = local.instance_sg_tags
}

resource "aws_vpc_security_group_egress_rule" "instance_allow_all_egress_rule" {
    security_group_id = aws_security_group.instance_sg.id
    description = "Allow all outbound traffic"
    to_port = 0
    from_port = 0
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "instance_allow_ssh_ingress_rule" {
    security_group_id = aws_security_group.instance_sg.id
    description = "Allow SSH ingress traffic"
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "instance_allow_http_ingress_rule" {
    security_group_id = aws_security_group.instance_sg.id
    description = "Allow HTTP ingress traffic"
    from_port = 80
    to_port =80
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
}