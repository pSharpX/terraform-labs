resource "aws_security_group" "onebank-instance-sg" {
    vpc_id = data.aws_vpc.onebank-vpc.id
    name = local.sec_group_name
    description = "Allows all required inbound/outbound traffic for backend instance"
    tags = local.sec_groups_tags
}

resource "aws_security_group_rule" "allow-all-egress" {
    type = "egress"
    description = "Allows all outbound traffic for instance"
    from_port = 0
    to_port = 0
    security_group_id = aws_security_group.onebank-instance-sg.id
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
}


resource "aws_security_group_rule" "allow-http" {
    type = "ingress"
    description = "Allow inbound traffic for HTTP"
    from_port = 80
    to_port = 80
    security_group_id = aws_security_group.onebank-instance-sg.id
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "allow-ssh" {
    type = "ingress"
    description = "Allow inbound traffic for SSH"
    from_port = 22
    to_port = 22
    security_group_id = aws_security_group.onebank-instance-sg.id
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
}
