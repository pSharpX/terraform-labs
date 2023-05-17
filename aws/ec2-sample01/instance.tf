resource "aws_instance" "ec2-aforo255-01" {
    ami = "ami-03c7d01cf4dedc891"
    instance_type = "t2.micro"
}