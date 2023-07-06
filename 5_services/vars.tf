variable "weather_api_key" {
    description = "API key required to access OpenWeatherMap API"
    type        = string
}

variable "expiration_sec" {
    description = "Amount of seconds until DynamoDB items are automatically deleted"
    type        = number
}

variable "static_s3_website_bucket" {
    description = "Name of s3 bucket to be used for hosting static content"
    type        = string
}

variable "maintainer" {
    description = "Application maintainer"
    type        = string
}
