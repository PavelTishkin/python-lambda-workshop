resource "aws_apigatewayv2_api" "WeatherAPI4_API_GW" {
  name          = "Lab4_WeatherAPI_HTTP_GW"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "WeatherAPI4_GW_Stage" {
  api_id = aws_apigatewayv2_api.WeatherAPI4_API_GW.id

  name        = "Lab4_WeatherAPI_GW"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.WeatherAPI4_CW_Log_Group.arn

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

resource "aws_apigatewayv2_integration" "WeatherAPI4_Integration" {
  api_id = aws_apigatewayv2_api.WeatherAPI4_API_GW.id

  integration_uri    = module.WeatherAPI4_Lambda.lambda_function_arn
  integration_type   = "AWS_PROXY"
  integration_method = "GET"
}

resource "aws_apigatewayv2_route" "WeatherAPI4_Route" {
  api_id = aws_apigatewayv2_api.WeatherAPI4_API_GW.id

  route_key = "GET /weather"
  target    = "integrations/${aws_apigatewayv2_integration.WeatherAPI4_Integration.id}"
}

resource "aws_cloudwatch_log_group" "WeatherAPI4_CW_Log_Group" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.WeatherAPI4_API_GW.name}"

  retention_in_days = 30
}

resource "aws_lambda_permission" "WeatherAPI4_Lambda_Permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.WeatherAPI4_Lambda.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.WeatherAPI4_API_GW.execution_arn}/*/*"
}

output "api_gw_url" {
  value = format("%s/%s/weather?city_name=",
    aws_apigatewayv2_api.WeatherAPI4_API_GW.api_endpoint,
    aws_apigatewayv2_stage.WeatherAPI4_GW_Stage.name)
}