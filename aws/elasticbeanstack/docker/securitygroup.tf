
resource "aws_security_group" "application_sg" {
    vpc_id = data.aws_vpc.onebank_vpc.id
    name = local.application_sg_name
    description = "Rules for configuring inbound/outbound traffic for instance"
    tags = local.application_sg_tags
}

resource "aws_security_group_rule" "allow_all" {
    type = "egress"
    security_group_id = aws_security_group.application_sg.id
    description = "Allow all outbound traffic"
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_http" {
    type = "ingress"
    security_group_id = aws_security_group.application_sg.id
    description = "Allow HTTP traffic"
    to_port = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_ssh_ipv4" {
    type = "ingress"
    security_group_id = aws_security_group.application_sg.id
    description = "Allow SSH ingress traffic"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}