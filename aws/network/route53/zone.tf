resource "aws_route53_zone" "onebank-zone" {
    name = local.zone_name
    tags = local.common_tags
}