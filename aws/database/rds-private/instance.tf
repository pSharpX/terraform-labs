
resource "aws_key_pair" "onebank-keypair" {
    key_name = local.key_name
    public_key = file(var.PATH_TO_PUBLIC_KEY)
    tags = local.key_tags
}

resource "aws_instance" "onebank-backend" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.onebank-keypair.key_name
    subnet_id = data.aws_subnet.main-public-1.id
    vpc_security_group_ids = [ aws_security_group.backend-sg.id ]
    user_data = filebase64(var.PATH_TO_USER_DATA)
    tags = local.instance_tags
}