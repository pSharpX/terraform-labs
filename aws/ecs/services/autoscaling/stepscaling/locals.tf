locals {
  task_definition_name = "${var.APPLICATION_NAME}-${var.ENVIRONMENT}"
  common_tags = {
    ApplicationId      = var.APPLICATION_ID
    TechnicalOwner     = var.TECHNICAL_OWNER
    Environment        = var.ENVIRONMENT
    DataClassification = var.DATA_CLASSIFICATION
    Provisioner        = var.PROVISIONER
  }
  alb_name    = "${var.APPLICATION_ID}-alb-${var.ENVIRONMENT}"
  alb_sg_name = "${var.APPLICATION_ID}-alb-sg-${var.ENVIRONMENT}"
  ecs_sg_name = "${var.APPLICATION_ID}-ecs-sg-${var.ENVIRONMENT}"
}