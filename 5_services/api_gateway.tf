resource "aws_apigatewayv2_api" "WeatherAPI5_API_GW" {
  name          = "Lab5_WeatherAPI_HTTP_GW"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "WeatherAPI5_API_GW_Stage" {
  api_id = aws_apigatewayv2_api.WeatherAPI5_API_GW.id

  name        = "lab5_weatherapi_gw"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.WeatherAPI5_API_GW_CloudWatch_Log_Group.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }

  tags = {
    owner = var.maintainer
  }
}

resource "aws_apigatewayv2_integration" "WeatherAPI5_API_GW_Integration" {
  api_id = aws_apigatewayv2_api.WeatherAPI5_API_GW.id

  integration_uri    = module.WeatherAPI5_DB_Query_Lambda.lambda_function_arn
  integration_type   = "AWS_PROXY"
  integration_method = "GET"
}

resource "aws_apigatewayv2_route" "WeatherAPI5_API_GW_Route" {
  api_id = aws_apigatewayv2_api.WeatherAPI5_API_GW.id

  route_key = "GET /weather"
  target    = "integrations/${aws_apigatewayv2_integration.WeatherAPI5_API_GW_Integration.id}"
}

resource "aws_cloudwatch_log_group" "WeatherAPI5_API_GW_CloudWatch_Log_Group" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.WeatherAPI5_API_GW.name}"

  retention_in_days = 30

  tags = {
    owner = var.maintainer
  }
}

resource "aws_lambda_permission" "WeatherAPI5_API_GW_Permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.WeatherAPI5_DB_Query_Lambda.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.WeatherAPI5_API_GW.execution_arn}/*/*"
}

output "api_gw_url" {
    value = aws_apigatewayv2_api.WeatherAPI5_API_GW.api_endpoint
}
