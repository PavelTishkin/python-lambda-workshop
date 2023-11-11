resource "aws_iam_policy" "WeatherAPI5_DDB_Write" {
    name        = "Lab5_WeatherAPI_DDB_Write"
    description = "Allow writing to DynamoDB"

    policy      = data.aws_iam_policy_document.WeatherAPI5_DDB_Write_Policy_Document.json    

    tags = {
        owner = var.maintainer
    }
}

data "aws_iam_policy_document" "WeatherAPI5_DDB_Write_Policy_Document" {
    statement {
        actions   = ["dynamodb:PutItem"]
        resources = [aws_dynamodb_table.WeatherAPI5_Data.arn]
    }
}

resource "aws_iam_policy" "WeatherAPI5_DDB_Read" {
    name        = "Lab5_WeatherAPI_DDB_Read"
    description = "Allow reading from DynamoDB"

    policy      = data.aws_iam_policy_document.WeatherAPI5_DDB_Read_Policy_Document.json    

    tags = {
        owner = var.maintainer
    }
}

data "aws_iam_policy_document" "WeatherAPI5_DDB_Read_Policy_Document" {
    statement {
        actions   = ["dynamodb:Query"]
        resources = ["*"]
    }
}
