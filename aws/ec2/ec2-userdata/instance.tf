resource "aws_instance" "aforo255-instance" {
    ami = "ami-080e1f13689e07408"
    instance_type = "t2.micro"
    key_name = aws_key_pair.aforo255-keypair.key_name
    user_data = filebase64(var.PATH_TO_USER_DATA)

    tags = {
        Name = "aforo255-instance"
        Application = "aforo255"
        Provisioner = "terraform"
    }
}