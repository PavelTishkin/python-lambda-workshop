variable "weather_api_key" {
    description = "API key required to access OpenWeatherMap API"
    type        = string
}

variable "lambda_name" {
    description = "Name of Lambda function"
    type        = string
}

variable "maintainer" {
    description = "Application maintainer"
    type        = string
}
