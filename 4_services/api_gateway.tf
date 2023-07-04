resource "aws_apigatewayv2_api" "weatherapi_gw4_api" {
  name          = "weather_api_http_gw_4"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "weatherapi_gw4_stage" {
  api_id = aws_apigatewayv2_api.weatherapi_gw4_api.id

  name        = "weatherapi_gw"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.weatherapi_gw4_cw_log_group.arn

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
}

resource "aws_apigatewayv2_integration" "weatherapi_integration4" {
  api_id = aws_apigatewayv2_api.weatherapi_gw4_api.id

  integration_uri    = module.Lambda_WeatherAPIP4.lambda_function_arn
  integration_type   = "AWS_PROXY"
  integration_method = "GET"
}

resource "aws_apigatewayv2_route" "weatherapi_route4" {
  api_id = aws_apigatewayv2_api.weatherapi_gw4_api.id

  route_key = "GET /weather"
  target    = "integrations/${aws_apigatewayv2_integration.weatherapi_integration4.id}"
}

resource "aws_cloudwatch_log_group" "weatherapi_gw4_cw_log_group" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.weatherapi_gw4_api.name}"

  retention_in_days = 30
}

resource "aws_lambda_permission" "weatherapi_gw4_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.weatherapi_gw4_api.execution_arn}/*/*"
}