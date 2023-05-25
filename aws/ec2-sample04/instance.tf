resource "aws_instance" "ec2-sample04" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.ec2-sample04-keypair.key_name}"

    # The vpc subnet
    subnet_id = "${aws_subnet.main-public-1.id}"

    # The security group
    vpc_security_group_ids = [ "${aws_security_group.allow-ssh.id}" ]

    tags = {
        Name: "ec2-sample04"
        Provisioner: "terraform"
    }
}