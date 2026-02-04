
resource "aws_security_group" "allow_traffic" {
    vpc_id = data.aws_vpc.default_vpc.id
    name = local.secgrup_name
    description = "Allows all required inbound traffic for web instance"

    ingress {
        description = "Allow inbound traffic for HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        description = "Allow outbound traffic for HTTPS"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = local.common_tags
}

resource "aws_security_group" "ecs_managed_instances_sg" {
    name = "ecs-managed-instances-sg"
    description = "Security group for ECS Managed Instances"
    vpc_id = data.aws_vpc.default_vpc.id

    # ---- INBOUND ----
    # Only if you want public HTTP access
    ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Optional HTTPS
    ingress {
        description = "HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # ---- OUTBOUND (CRITICAL) ----
    egress {
        description = "Allow all outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = local.common_tags
}
