resource "aws_key_pair" "ec2-sample03-keypair" {
    key_name = "ec2-sample03-keypair"
    public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"
}

resource "aws_instance" "ec2-aforo255-03" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.ec2-sample03-keypair.key_name}"

    provisioner "file" {
        source = "script.sh"
        destination = "/tmp/script.sh"

        connection {
            host = "${aws_instance.ec2-aforo255-03.public_ip}"
            user = "${var.INSTANCE_USERNAME}"
            private_key = "${file(var.PATH_TO_PRIVATE_KEY)}"
        }
    }

    provisioner "remote-exec" {
        inline = [ 
            "chmod +x /tmp/script.sh",
            "sudo /tmp/script.sh"
        ]

        connection {
            host = "${aws_instance.ec2-aforo255-03.public_ip}"
            user = "${var.INSTANCE_USERNAME}"
            private_key = "${file(var.PATH_TO_PRIVATE_KEY)}"
        }
    }
}