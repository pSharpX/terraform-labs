output "ec2-instance-ip" {
    value = aws_instance.ec2-sample04.public_ip
}

output "ec2-instance-dns" {
    value = aws_instance.ec2-sample04.public_dns
}