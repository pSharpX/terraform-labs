resource "aws_security_group" "backend-sg" {
    vpc_id = data.aws_vpc.onebank-vpc.id
    name = local.backend_sg
    description = "Allows all required inbound/outbound traffic for backend instance"

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        description = "Allow inbound traffic for HTTP"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = local.backend_sg_tags
}

resource "aws_security_group_rule" "backend-sg-rule" {
    type = "ingress"
    description = "Allow inbound traffic from gateway instance"
    from_port = 0
    to_port = 0
    security_group_id = aws_security_group.backend-sg.id
    source_security_group_id = aws_security_group.gateway-sg.id
    protocol = "-1"
}

resource "aws_security_group" "database-sg" {
    vpc_id = data.aws_vpc.onebank-vpc.id
    name = local.database_sg
    description = "Allows all required inbound/outbound traffic for database instance"

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        description = "Allow inbound traffic for MariaDB Engine"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = local.database_sg_tags
}

resource "aws_security_group_rule" "database-sg-rule" {
    type = "ingress"
    description = "Allow inbound traffic from backend instance"
    from_port = 0
    to_port = 0
    security_group_id = aws_security_group.database-sg.id
    source_security_group_id = aws_security_group.backend-sg.id
    protocol = "-1"
}

resource "aws_security_group" "frontend-sg" {
    vpc_id = data.aws_vpc.onebank-vpc.id
    name = local.frontend_sg
    description = "Allows all required inbound/outbound traffic for frontend instance"

    egress {
        description = "Allow all outbound traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        description = "Allow inbound traffic for HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        description = "Allow inbound traffic for SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = local.frontend_sg_tags
}

resource "aws_security_group" "gateway-sg" {
    vpc_id = data.aws_vpc.onebank-vpc.id
    name = local.gateway_sg
    description = "Allows all required inbound/outbound traffic for gateway instance"

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        description = "Allow inbound traffic for HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        description = "Allow inbound traffic for SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = local.gateway_sg_tags
}