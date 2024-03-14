resource "aws_security_group" "onebank-instance-sg" {
    vpc_id = data.aws_vpc.onebank-vpc.id
    name = local.sec_group_name
    description = "Allows all required inbound/outbound traffic for backend instance"
    tags = local.sec_groups_tags
}

resource "aws_security_group_rule" "instance-allow-all-egress" {
    type = "egress"
    description = "Allows all outbound traffic for instance"
    from_port = 0
    to_port = 0
    security_group_id = aws_security_group.onebank-instance-sg.id
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "instance-allow-ssh" {
    type = "ingress"
    description = "Allow inbound traffic for SSH"
    from_port = 22
    to_port = 22
    security_group_id = aws_security_group.onebank-instance-sg.id
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "instance-allow-http" {
    type = "ingress"
    description = "Allow inbound traffic for HTTP"
    from_port = 80
    to_port = 80
    security_group_id = aws_security_group.onebank-instance-sg.id
    source_security_group_id = aws_security_group.onebank-elb-sg.id
    protocol = "tcp"
}

resource "aws_security_group" "onebank-elb-sg" {
    vpc_id = data.aws_vpc.onebank-vpc.id
    name = local.elb_secgroup_name
    description = "Allows all required inbound/outbound traffic for ELB"
    tags = local.elb_secgroup_tags
}

resource "aws_security_group_rule" "elb-allow-all-egress" {
    type = "egress"
    description = "Allows all outbound traffic for ELB"
    from_port = 0
    to_port = 0
    security_group_id = aws_security_group.onebank-elb-sg.id
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "elb-allow-http" {
    type = "ingress"
    description = "Allow inbound traffic for HTTP"
    from_port = 80
    to_port = 80
    security_group_id = aws_security_group.onebank-elb-sg.id
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
}