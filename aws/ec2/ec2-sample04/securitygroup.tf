resource "aws_security_group" "allow-ssh" {
    vpc_id = "${aws_vpc.vpc-sample01.id}"
    name = "allow-ssh"
    description = "security group that allows ssh and all egress trafic"

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        description = "SSH from VPC"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
        Name: "allow-ssh"
        Provisioner: "terraform"
    }
}