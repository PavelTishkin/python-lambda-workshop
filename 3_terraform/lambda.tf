module "WeatherAPI3_Lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name    = "WeatherAPI3"
  description      = "Retrieves current weather"
  handler          = "index.lambda_handler"
  runtime          = "python3.10"

  source_path      = "weather_api"

  layers = [
    module.WeatherAPI3_Layer.lambda_layer_arn
  ]

  environment_variables = {
    "API_KEY"      = var.weather_api_key
  }

  role_name        = "WeatherAPI3_Role"
  role_description = "Default Lambda permissions"
  role_tags        = {
    owner          = var.maintainer
  }

  tags = {
    owner          = var.maintainer
  }
}

module "WeatherAPI3_Layer" {
  source              = "terraform-aws-modules/lambda/aws"

  create_layer        = true

  layer_name          = "WeatherAPI3_Requests"
  description         = "Layer containing libraries for WeatherAPI Lambda"

  compatible_runtimes = ["python3.10"]

  source_path         = "requests_layer"

  tags = {
    owner          = var.maintainer
  }
}
