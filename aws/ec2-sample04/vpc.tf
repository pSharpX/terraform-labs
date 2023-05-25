resource "aws_vpc" "vpc-sample01" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    enable_classiclink = false
    tags = {
        Name: "main"
        Description: "vpc-sample01"
        Provisioner: "terraform"
    }
}