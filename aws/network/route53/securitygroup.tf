resource "aws_security_group" "allow-ssh" {
    vpc_id = "${aws_vpc.onebank-vpc.id}"
    name = "allow-ssh"
    description = "security group that allows ssh and all egress trafic"
    tags = {
        Name: "allow-ssh"
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh-ipv4" {
    security_group_id = aws_security_group.allow-ssh.id
    description = "SSH from VPC"
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
    tags = {
        Name: "allow-ssh-ipv4"
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
}

resource "aws_vpc_security_group_egress_rule" "allow-all" {
    security_group_id = aws_security_group.allow-ssh.id
    description = "Allow all outbound traffic from instance"
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
    tags = {
        Name: "allow-all"
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
}