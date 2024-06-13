check "validations" {
    assert {
      condition = var.INSTANCE_COUNT >= 1 && var.INSTANCE_COUNT <= 10
      error_message = "INSTANCE_COUNT must be a positive number and lower or equal to 10"
    }

    assert {
        condition = var.MAX_REPLICAS <= 10 && var.MAX_REPLICAS >= var.INSTANCE_COUNT
        error_message = "MAX_REPLICAS must be a positive number and greater or equal to INSTANCE_COUNT"
    }

    assert {
        condition = var.MIN_REPLICAS >= 1 && var.MIN_REPLICAS <= var.INSTANCE_COUNT
        error_message = "MIN_REPLICAS must be a positive number and lower or equal to INSTANCE_COUNT"
    }
}