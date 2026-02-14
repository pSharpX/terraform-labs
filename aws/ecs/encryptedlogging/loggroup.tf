
resource "aws_cloudwatch_log_group" "cluster_log_group" {
  name = "${local.cluster_name}-lg"
}