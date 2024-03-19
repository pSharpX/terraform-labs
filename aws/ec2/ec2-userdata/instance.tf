resource "aws_instance" "aforo255-instance" {
    ami = local.ami_id
    instance_type = "t2.micro"
    key_name = aws_key_pair.aforo255-keypair.key_name
    user_data = filebase64(local.script)

    tags = local.instance_tags
}