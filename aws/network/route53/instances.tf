resource "aws_key_pair" "onebank-keypair" {
    key_name = "onebank-keypair"
    public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"

    tags = {
        Name = "onebank-keypair"
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
}

resource "aws_instance" "backend-instance" {
    ami = data.aws_ami.al2023.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.onebank-keypair.key_name
    subnet_id = aws_subnet.main-public-1.id
    vpc_security_group_ids = [ aws_security_group.allow-ssh.id ]

    tags = {
        Name = "onebank-backend-instance"
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
}

resource "aws_instance" "frontend-instance" {
    ami = data.aws_ami.al2023.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.onebank-keypair.key_name
    subnet_id = aws_subnet.main-public-1.id
    security_groups = [ aws_security_group.allow-ssh.id ]

    tags = {
        Name = "onebank-frontend-instance"
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
}