
resource "aws_security_group" "database-sg" {
    vpc_id = data.aws_vpc.onebank-vpc.id
    name = local.sg_name
    description = "Rules for configuring inbound/outbound traffic for database"
    tags = local.secgroup_tags
}

resource "aws_security_group_rule" "allow-database-egress-rule" {
    type = "egress"
    security_group_id = aws_security_group.database-sg.id
    description = "Allow all outbound traffic"
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "allow-backend-ingress-rule" {
    type = "ingress"
    security_group_id = aws_security_group.database-sg.id
    description = "Allow ingress traffic from Backend Instance"
    source_security_group_id = aws_security_group.backend-sg.id
    to_port = 0
    from_port = 0
    protocol = "-1"
}

resource "aws_security_group" "backend-sg" {
    vpc_id = data.aws_vpc.onebank-vpc.id
    name = local.instance_sg_name
    description = "Rules for configuring inbound/outbound traffic for instance"
    tags = local.instance_sg_tags
}

resource "aws_security_group_rule" "allow-all" {
    type = "egress"
    security_group_id = aws_security_group.backend-sg.id
    description = "Allow all outbound traffic"
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow-database-egress" {
    type = "egress"
    security_group_id = aws_security_group.backend-sg.id
    description = "Allow all outbound traffic"
    to_port = 0
    from_port = 0
    protocol = "-1"
    source_security_group_id = aws_security_group.database-sg.id
}

resource "aws_security_group_rule" "allow-ssh-ipv4" {
    type = "ingress"
    security_group_id = aws_security_group.backend-sg.id
    description = "Allow SSH ingress traffic"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}