output "backend" {
    value = {
        "private_ip": aws_instance.onebank-backend.private_ip
    }
}

output "database" {
    value = {
        "private_ip": aws_instance.onebank-database.private_ip
    }
}

output "frontend" {
    value = {
        "private_ip": aws_instance.onebank-frontend.private_ip
        "public_dns": aws_instance.onebank-frontend.public_dns
        "ssh": "ssh -i ${var.PATH_TO_PRIVATE_KEY} ubuntu@${aws_instance.onebank-frontend.public_ip}"
    }
}

output "gateway" {
    value = {
        "private_ip": aws_instance.onebank-gateway.private_ip
        "public_dns": aws_instance.onebank-gateway.public_dns
        "ssh": "ssh -i ${var.PATH_TO_PRIVATE_KEY} ubuntu@${aws_instance.onebank-gateway.public_ip}"
    }
}
