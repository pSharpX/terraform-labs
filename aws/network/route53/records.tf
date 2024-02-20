resource "aws_route53_record" "backend-record" {
    zone_id = aws_route53_zone.onebank-zone.zone_id
    name = local.backend_record
    type = "A"
    ttl = 300
    records = [ aws_instance.backend-instance.public_ip ]
}

resource "aws_route53_record" "frontend-record" {
    zone_id = aws_route53_zone.onebank-zone.zone_id
    name = local.frontend_record
    type = "A"
    ttl = 300
    records = [ aws_instance.frontend-instance.public_ip ]
}