resource "aws_dynamodb_table" "WeatherAPI5_Data" {
    name         = "WeatherAPI5_Data"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "dt"
    range_key    = "read_date"

    attribute {
        name = "dt"
        type = "N"
    }

    attribute {
        name = "read_date"
        type = "S"
    }

    global_secondary_index {
        name            = "read_date-index"
        hash_key        = "read_date"
        projection_type = "ALL"
    }

    ttl {
        attribute_name = "expiration"
        enabled        = true
    }

    lifecycle {
      prevent_destroy  = true
    }

    tags = {
        owner = var.maintainer
    }
}
