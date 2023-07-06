module "WeatherAPI5_API_Query_Lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name       = "WeatherAPI5_API_Query"
  description         = "Retrieves current weather and stores data in Dynamo DB"
  handler             = "index.lambda_handler"
  runtime             = "python3.10"

  source_path         = "weatherapi_api_query"

  layers = [
    module.WeatherAPI5_Requests_Layer.lambda_layer_arn
  ]

  environment_variables = {
    "API_KEY"         = var.weather_api_key
    "DATA_TABLE_NAME" = aws_dynamodb_table.WeatherAPI5_Data.name
    "EXPIRATION_SEC"  = var.expiration_sec

  }

  role_name           = "WeatherAPI5_API_Query"
  role_description    = "Lambda permissions to access DynamoDB"
  role_tags           = {
    owner             = var.maintainer
  }

  attach_policies     = true
  number_of_policies  = 1
  policies            = [
    aws_iam_policy.WeatherAPI5_DDB_Write.arn
  ]

  tags = {
    owner          = var.maintainer
  }
}

module "WeatherAPI5_DB_Query_Lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name       = "WeatherAPI5_DB_Query"
  description         = "Retrieves temperatures from DynamoDB and returns as response"
  handler             = "index.lambda_handler"
  runtime             = "python3.10"

  source_path         = "weatherapi_db_query"

  environment_variables = {
    "DATA_TABLE_NAME" = aws_dynamodb_table.WeatherAPI5_Data.name
  }

  role_name           = "WeatherAPI5_DB_Query"
  role_description    = "Lambda permissions to access DynamoDB"
  role_tags           = {
    owner             = var.maintainer
  }

  attach_policies     = true
  number_of_policies  = 1
  policies            = [
    aws_iam_policy.WeatherAPI5_DDB_Read.arn
  ]

  tags = {
    owner          = var.maintainer
  }
}

module "WeatherAPI5_Requests_Layer" {
  source              = "terraform-aws-modules/lambda/aws"

  create_layer        = true

  layer_name          = "WeatherAPI5_Requests"
  description         = "Layer containing requests library for WeatherAPI Lambda"

  compatible_runtimes = ["python3.10"]

  source_path         = "requests_layer"

  tags = {
    owner          = var.maintainer
  }
}
