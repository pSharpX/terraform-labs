
resource "aws_security_group" "database_sg" {
    vpc_id = var.VPC_ID
    name = "database-sg"
    description = "Rules for configuring inbound/outbound traffic for database"
    tags = local.common_tags
}

resource "aws_security_group_rule" "allow_database_egress_rule" {
    type = "egress"
    security_group_id = aws_security_group.database_sg.id
    description = "Allow all outbound traffic"
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
}
