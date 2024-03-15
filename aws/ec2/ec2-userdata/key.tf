resource "aws_key_pair" "aforo255-keypair" {
    key_name = "aforo255-keypair"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
    tags = {
      application = "aforo255"
      name = "aforo255-keypair"
    }
}