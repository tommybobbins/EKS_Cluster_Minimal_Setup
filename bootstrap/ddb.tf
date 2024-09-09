
resource "aws_dynamodb_table" "terraform-lock" {
    name           = "terraform_state"
    hash_key       = "LockID"
    billing_mode = "PROVISIONED"
    read_capacity = 1
    write_capacity = 1
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        "Name" = "DDB Terraform State Lock Table"
    }
}