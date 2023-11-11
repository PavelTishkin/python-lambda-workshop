resource "aws_cloudwatch_event_rule" "WeatherAPI5_Event_Rule" {
    name                = "Lab5_WeatherAPI_ScheduledQuery"
    description         = "Execute Lambda on a schedule every 5 minutes to retrieve current temperature"
    schedule_expression = "cron(*/5 * * * ? *)"

    tags = {
        owner = var.maintainer
    }
}

resource "aws_cloudwatch_event_target" "WeatherAPI5_Event_Target" {
    target_id = module.WeatherAPI5_API_Query_Lambda.lambda_function_name
    arn       = module.WeatherAPI5_API_Query_Lambda.lambda_function_arn
    rule      = aws_cloudwatch_event_rule.WeatherAPI5_Event_Rule.name

    input = "{\"city_name\": \"Dublin, IE\"}"
}

resource "aws_lambda_permission" "WeatherAPI5_AllowEventBridge" {
    action = "lambda:InvokeFunction"
    function_name = module.WeatherAPI5_API_Query_Lambda.lambda_function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.WeatherAPI5_Event_Rule.arn
}
