
resource "aws_ecs_cluster" "onebank_cluster" {
  name = local.cluster_name
  tags = local.cluster_tags

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.cluster_key.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.cluster_log_group.name
      }
    }
  }

  depends_on = [aws_kms_key_policy.key_policies]
}