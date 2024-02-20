resource "aws_key_pair" "ec2-sample04-keypair" {
    key_name = "ec2-sample04-keypair"
    public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"

    tags = {
        Name: "ec2-sample04-keypair"
        Provisioner: "terraform"
    }
}