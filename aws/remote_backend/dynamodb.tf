
# DynamoDB table for state locking to prevent concurrent modifications
resource "aws_dynamodb_table" "lock" {
  name         = "tf-state-locks-${var.ENVIRONMENT}-stack"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}