variable "profile" {
    description = "Contains AWS profile name used to connect to your account"
    type        = string
    default     = "default"
}

variable "weather_api_key" {
    description = "API key required to access OpenWeatherMap API"
    type        = string
}

variable "maintainer" {
    description = "Application maintainer"
    type        = string
}
