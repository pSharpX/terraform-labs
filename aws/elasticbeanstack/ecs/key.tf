resource "aws_key_pair" "onebank_key" {
    key_name = local.key_name
    public_key = file(var.PATH_TO_PUBLIC_KEY)
    tags = local.key_tags
}