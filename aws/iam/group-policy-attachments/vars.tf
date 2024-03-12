variable "AWS_REGION" {
    type = string
    default = "us-east-1"
}

variable "AWS_ACCESS_KEY" {
    type = string
    sensitive = true
    description = "AWS credentials (accessKey)"
}

variable "AWS_SECRET_KEY" {
    type = string
    sensitive = true
    description = "AWS credentials (secretKey)"
}

variable "DEVELOPER_GROUP" {
    type = string
    default = "developers"
    description = "Group name for developer users with restricted permissions"
}

variable "ADMINISTRATOR_GROUP" {
    type = string
    default = "administrators"
    description = "Group name for administrator users with full access"
}

variable "GROUPS" {
    type = set(string)
    default = [ "guests", "contractors", "externals" ]
    description = "Groups name for external users with limit permissions"
}