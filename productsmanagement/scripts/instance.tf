resource "aws_instance" "instance" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.keypair.key_name
    tags = local.instance_tags
}