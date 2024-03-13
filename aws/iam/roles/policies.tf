data "aws_iam_policy_document" "onebank-s3-developer-bucket" {
    version = "2012-10-17"

    statement {
        actions = [ "s3:*" ]
        effect = "Allow"
        resources = [ 
            "${data.aws_s3_bucket.onebank-s3-bucket.arn}",
            "${data.aws_s3_bucket.onebank-s3-bucket.arn}/*"
         ]
    }
}
resource "aws_iam_policy" "onebank-s3-policy" {
    name = "onebank-s3-policy"
    description = "Custom Policy for S3 bucket access"
    policy = data.aws_iam_policy_document.onebank-s3-developer-bucket.json
    tags = local.common_tags
}
