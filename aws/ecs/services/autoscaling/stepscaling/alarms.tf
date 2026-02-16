
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${local.service_name}-ecs-cpu-high"
  alarm_description   = "This metric monitors cpu utilization for ${local.service_name}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  tags                = local.common_tags

  dimensions = {
    ClusterName = data.aws_ecs_cluster.default.cluster_name
    ServiceName = aws_ecs_service.default_service.name
  }

  alarm_actions = [aws_appautoscaling_policy.cpu_scale_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${local.service_name}-ecs-cpu-low"
  alarm_description   = "This metric monitors cpu utilization for ${local.service_name}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 30
  tags                = local.common_tags

  dimensions = {
    ClusterName = data.aws_ecs_cluster.default.cluster_name
    ServiceName = aws_ecs_service.default_service.name
  }

  alarm_actions = [aws_appautoscaling_policy.cpu_scale_in.arn]
}

