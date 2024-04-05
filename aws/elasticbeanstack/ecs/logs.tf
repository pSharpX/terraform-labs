# resource "aws_cloudwatch_log_group" "onebank_application_lg" {
#     name = "${local.application_name}-${var.ENVIRONMENT}"
#     retention_in_days = 7
#     tags = local.common_tags
# }

# resource "aws_cloudwatch_log_stream" "onebank_application_lg_stream" {
#     name = "productsmanagement"
#     log_group_name = aws_cloudwatch_log_group.onebank_application_lg.name
# }