resource "aws_instance" "ec2-aforo255-02" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
}