
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

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  alarm_name          = "${local.service_name}-ecs-memory-high"
  alarm_description   = "This metric monitors memory utilization for ${local.service_name}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 75
  tags                = local.common_tags

  dimensions = {
    ClusterName = data.aws_ecs_cluster.default.cluster_name
    ServiceName = aws_ecs_service.default_service.name
  }

  alarm_actions = [aws_appautoscaling_policy.mem_scale_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_memory_low" {
  alarm_name          = "${local.service_name}-ecs-cpu-memory-low"
  alarm_description   = "This metric monitors both cpu & memory utilization for ${local.service_name}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 3
  threshold           = 30
  treat_missing_data  = "notBreaching"
  tags                = local.common_tags

  # CPU metric
  metric_query {
    id = "cpu"
    metric {
      namespace   = "AWS/ECS"
      metric_name = "CPUUtilization"
      period      = 60
      stat        = "Average"
      dimensions = {
        ClusterName = data.aws_ecs_cluster.default.cluster_name
        ServiceName = aws_ecs_service.default_service.name
      }
    }
  }

  # Memory metric
  metric_query {
    id = "mem"
    metric {
      namespace   = "AWS/ECS"
      metric_name = "MemoryUtilization"
      period      = 60
      stat        = "Average"
      dimensions = {
        ClusterName = data.aws_ecs_cluster.default.cluster_name
        ServiceName = aws_ecs_service.default_service.name
      }
    }
  }

  # Expression: BOTH must be low
  metric_query {
    id          = "expr"
    expression  = "MAX([cpu, mem])"
    label       = "cpu_mem_max"
    return_data = true
  }

  alarm_actions = [aws_appautoscaling_policy.scale_in_policy.arn]
}
