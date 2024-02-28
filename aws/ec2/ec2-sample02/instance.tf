resource "aws_key_pair" "onebank-key" {
    key_name = local.key_name
    public_key = file(var.PATH_TO_PUBLIC_KEY)
    tags = local.key_tags
}

resource "aws_instance" "onebank-backend" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.onebank-key.key_name
    subnet_id = data.aws_subnet.main-private-1.id
    vpc_security_group_ids = [ aws_security_group.backend-sg.id ]
    tags = local.backend_tags
}

resource "aws_instance" "onebank-database" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.onebank-key.key_name
    subnet_id = data.aws_subnet.main-private-2.id
    vpc_security_group_ids = [ aws_security_group.database-sg.id ]
    tags = local.database_tags
}

resource "aws_instance" "onebank-frontend" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.onebank-key.key_name
    subnet_id = data.aws_subnet.main-public-1.id
    vpc_security_group_ids = [ aws_security_group.frontend-sg.id ]
    tags = local.frontend_tags
}

resource "aws_instance" "onebank-gateway" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.onebank-key.key_name
    subnet_id = data.aws_subnet.main-public-2.id
    vpc_security_group_ids = [ aws_security_group.gateway-sg.id ]
    tags = local.gateway_tags
}