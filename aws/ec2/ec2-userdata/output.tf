output "instance-ip" {
    value = aws_instance.aforo255-instance.public_ip
}

output "instance-ssh" {
    value = "ssh -i ${var.PATH_TO_PRIVATE_KEY} ubuntu@${aws_instance.aforo255-instance.public_ip}"
}