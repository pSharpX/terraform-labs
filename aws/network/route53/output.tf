output "backend-instance-ip" {
    value = aws_instance.backend-instance.public_ip
}

output "ssh-backend" {
    value = "ssh -i ${var.PATH_TO_PRIVATE_KEY} ec2-user@${aws_instance.backend-instance.public_ip}"
}

output "api-url" {
    value = aws_route53_record.backend-record.fqdn
}

output "frontend-instance-ip" {
    value = aws_instance.frontend-instance.public_ip
}

output "ssh-frontend" {
    value = "ssh -i ${var.PATH_TO_PRIVATE_KEY} ec2-user@${aws_instance.frontend-instance.public_ip}"
}

output "site-url" {
    value = aws_route53_record.frontend-record.fqdn
}

output "ns-servers" {
    value = aws_route53_zone.onebank-zone.name_servers
}