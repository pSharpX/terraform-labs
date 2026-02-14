locals {
  cluster_type         = "fg"
  cluster_name         = "${var.CLUSTER_NAME}-${var.ENVIRONMENT}-${local.cluster_type}-ecs"
  task_definition_name = "${var.APPLICATION_NAME}-${var.ENVIRONMENT}"
  common_tags = {
    ApplicationId      = var.APPLICATION_ID
    TechnicalOwner     = var.TECHNICAL_OWNER
    Environment        = var.ENVIRONMENT
    DataClassification = var.DATA_CLASSIFICATION
    Provisioner        = var.PROVISIONER
  }
  cluster_tags = merge({ Name = local.cluster_name }, local.common_tags)
  alb_name     = "${var.APPLICATION_ID}-alb-${var.ENVIRONMENT}"
  alb_sg_name  = "${var.APPLICATION_ID}-alb-sg-${var.ENVIRONMENT}"
  ecs_sg_name  = "${var.APPLICATION_ID}-ecs-sg-${var.ENVIRONMENT}"
}